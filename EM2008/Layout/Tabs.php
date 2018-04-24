<?php
class tabs {
	var $name;
	var $tabs;
	var $active;
	var $current;

	function __construct($name){
		$this->name = $name;
	}

	function start($name){
		if (empty($this->active)){ $this->active = $name; }
		$this->current = $name;
		ob_start();
	}

	function end(){
		$this->tabs[$this->current] = ob_get_contents();
		ob_end_clean();
	}

	function run(){
		if (count($this->tabs) > 0){
			echo "<DIV CLASS='tabs'>\n";
			$jsClear = "";
			foreach($this->tabs as $tabname => $tabcontent){
				$tabid = "tab_".$this->name."_$tabname";
				$contentid = "tabcontent_".$this->name."_$tabname";
				$jsClear .= "\tdocument.getElementById('$tabid').className = 'tab_inactive';\n";
				$jsClear .= "\tdocument.getElementById('$contentid').style.display = 'none';\n";
				$jsClear .= "if(\tdocument.getElementById('infos') != null){\n";
				$jsClear .= "\tdocument.getElementById('infos').style.display = 'none';\n";
				$jsClear .= "}\n";
				$jsClear .= "if(\tdocument.getElementById('errors') != null){\n";
				$jsClear .= "\tdocument.getElementById('errors').style.display = 'none';\n";
				$jsClear .= "}\n";
			}
			echo "<script type=\"text/javascript\">\n";
			echo "function tab_".$this->name."(id){\n";
			echo "$jsClear";
			echo "\tdocument.getElementById('tab_".$this->name."_'+id).className = 'tab_active';\n";
			echo "\tdocument.getElementById('tabcontent_".$this->name."_'+id).style.display = '';\n";
			echo "}\n";
			echo "</script>\n";
			echo "<div class='col-lg-8 col-xl-9'>";
			echo "<ul class='nav nav-tabs' id='myTab'>";
			foreach($this->tabs as $tabname => $tabcontent){
				$tabid = "tab_".$this->name."_$tabname";
				$contentid = "tabcontent_".$this->name."_$tabname";
				echo "<li class='";
				if ($this->active == $tabname){ echo "active"; }
				echo "' ID='$tabid' ";
				echo "onClick=\"tab_".$this->name."('$tabname');\"><a href='#' data-toggle='tab'>$tabname</a></li>\n";
			}

			echo "</ul>";
			echo "</div>";
			//echo "<DIV STYLE='float: left; clear:both;'></DIV>\n";
			foreach($this->tabs as $tabname => $tabcontent){
				$contentid = "tabcontent_".$this->name."_$tabname";
				echo "<DIV ID = '$contentid' CLASS='tab_content' STYLE='display: ";
				if ($this->active == $tabname){ echo "block"; }else{ echo "none"; }
				echo ";'>$tabcontent</DIV>\n";
			}
			echo "</DIV>\n";
			echo "<DIV STYLE='clear: both;'></DIV>\n";
		}
	}
}
?>
