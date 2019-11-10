<?PHP
include('simple_html_dom.php');
date_default_timezone_set('Asia/Krasnoyarsk');
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
function gism_temp(){
$html = file_get_html('https://www.gismeteo.ru/city/daily/11565/');
	//var_dump($html);
	$r = $html->find('.tab-weather');
	$div = ($r[0]->find('div'));
	return str_replace(",", ".", str_replace("&plus;","+",str_replace("&minus;","-",(trim(($div[0]->plaintext))))));
}
function avg($array){
	$res = 0;
	for ($i = 0; $i < count($array); $i++){
		$res +=$array[$i];
	}
	return $res / count($array);
}
function readFromFileToArray($f){
	$temp = [];
	while(!feof($f)){
		$t = trim(fgets($f));
		if ($t !== "")
			$temp[] = $t;
	}
	return $temp;
}
function clearFile($name){
	$f = fopen($name, 'w');
		fwrite($f, '');
		fclose($f);
}
if (isset($_GET['temp'])){
	$f = fopen(__DIR__.'/five_res', 'a');
	fwrite($f, $_GET['temp']."\n");
	fclose($f);
	$g = fopen(__DIR__.'/five_res_g', 'a');
	fwrite($g, gism_temp()."\n");
	fclose($g);
	if (date("i", time()) % 5 == 0){
		$r = fopen(__DIR__.'/ratings', 'r');
		$ratings = readFromFileToArray($r);
		fclose($r);
		$f = fopen(__DIR__.'/five_res', 'r');
		$temp_5res = readFromFileToArray($f);
		if(count($temp_5res) > 0){
			$avg = avg($temp_5res);
		if ($avg > $ratings[0]){
			$ratings[0] = $avg;
			$ratings[1] = time();
		}
			
		if ($avg < $ratings[2]){
			$ratings[2] = $avg;
			$ratings[3] = time();
		}
			
		$r = fopen(__DIR__.'/ratings', 'w');
		fwrite($r, $ratings[0]."\n".$ratings[1]."\n".$ratings[2]."\n".$ratings[3]);
		fclose($r);
		
		fclose($f);
		clearFile(__DIR__.'/five_res');
		$time = time();
		
		if (!is_dir(__DIR__.'/diary/'.date('Y/m/', $time)))
			mkdir(__DIR__.'/diary/'.date('Y/m/', $time), 0775, true);
	
		$f = fopen(__DIR__.'/diary/'.date('Y/m/d', $time), 'a');
		fwrite($f, $avg."\n");
		fwrite($f, $time."\n");
		fclose($f);
		
		$g = fopen(__DIR__.'/five_res_g', 'r');
		$avg_g = avg(readFromFileToArray($g));
		fclose($g);
		clearFile(__DIR__.'/five_res_g');
		$g = fopen(__DIR__.'/diary/'.date('Y/m/d', $time)."_g", 'a');
		fwrite($g, $avg."\n");
		fwrite($g, $time."\n");
		fclose($g);
		}
	}
die('Received successfully at '.(time() + 7 * 3600).' sec.');
}
?>
