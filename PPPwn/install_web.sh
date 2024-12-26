<?php

$firmwares = array("7.00", "7.01", "7.02", "7.50", "7.51", "7.55", "8.00", "8.01", "8.03", "8.50", "8.52", "9.00", "9.03", "9.04", "9.50", "9.51", "9.60", "10.00", "10.01", "10.50", "10.70", "10.71", "11.00");
$stage2jail = array("GoldHen", "Hen", "flow", "bestpig");
$cppm = array("1 - v1.0", "2 - PI", "3 - 最新", "4 - 其他");
$detectm = array("1 - 关闭", "2 - 检测主机开机", "3 - 检测GoldHEN运行", "4 - 检测两种模式");
$sourceipv6 = array("1 - 旧IPv6", "2 - 新IPv6", "3 - 自定义IPv6");

if (isset($_POST['save'])){
	$config = "#!/bin/bash\n";
	$config .= "CPPMETHOD=\\\"".str_replace(" ", "", trim($_POST["cppmethod"]))."\\\"\n";
	$config .= "INTERFACE=\\\"".str_replace(" ", "", trim($_POST["interface"]))."\\\"\n";
	$config .= "FIRMWAREVERSION=\\\"".$_POST["firmware"]."\\\"\n";
	$config .= "USBETHERNET=".(isset($_POST["usbether"]) ? "true" : "false")."\n";
	$config .= "STAGE2METHOD=\\\"".str_replace(" ", "", trim($_POST["stage2method"]))."\\\"\n";
	$config .= "SOURCEIPV6=\\\"".str_replace(" ", "", trim($_POST["sourceip"]))."\\\"\n";
	$config .= "CUSTOMIPV6=\\\"".str_replace(" ", "", trim($_POST["customip"]))."\\\"\n";
	$config .= "DETECTMODE=\\\"".str_replace(" ", "", trim($_POST["detectmode"]))."\\\"\n";
	$config .= "PPPOECONN=".(isset($_POST["pppoeconn"]) ? "true" : "false")."\n";
	$config .= "PWNAUTORUN=".(isset($_POST["pwnautorun"]) ? "true" : "false")."\n";
	$config .= "PPDBG=".(isset($_POST["ppdbg"]) ? "true" : "false")."\n";
	$config .= "TIMEOUT=\\\"".str_replace(" ", "", trim($_POST["timeout"]))."\\\"\n";
	exec('echo "'.$config.'" | sudo tee /boot/firmware/PPPwn/config.sh');
	sleep(2);

	if (isset($_POST["pppoeconn"]) == false)
	{
		print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}</style><body><br><br><br><center>Web服务器已禁用！<br>自动关机和自动pwn已激活。<br>如需禁用调试输出，请设置PPDBG=false<br>通过更改PPPOECONN=true再次启用Web服务器</center></body></html>");
		sleep(1);
		exec('sudo poweroff > /dev/null 2>&1 &');
		exit;
	}
	
	if (($_POST["stage2method"] == "goldhen") || ($_POST["stage2method"] == "bestpig")){
	if (!file_exists('/boot/firmware/PPPwn/stage2/'.$_POST["stage2method"].'/stage2_'.str_replace(".","",$_POST["firmware"]).'.bin'))
	{
		print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}a {padding: 5px 5px;font-size:20px; padding:4px; color:6495ED;} a:hover,a:focus {color: #999999;text-decoration: none;cursor: pointer;}</style><body><br><br><br><center>PPPwn not support this firmware.<br>It will use TheOfficialFloW or change stage2 jailbreak type.<br><br><a href=index.php>Back to main page</a></center></body></html>");
		sleep(1);
		exit;
	}
	}
}

if (isset($_POST['force'])){
	if (file_exists('/tmp/ps4alreadypwned.txt'))
	{
		sleep(1);
		print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}a {padding: 5px 5px;font-size:20px; padding:4px; color:6495ED;} a:hover,a:focus {color: #999999;text-decoration: none;cursor: pointer;}</style><body><br><br><br><center>PS4是否已经被破解？<br>在主页面重置折腾状态以再次折腾。<br><br><a href=index.php>返回主页面</a></center></body></html>"); 
		exit;
	}
	else
	{
		sleep(1);
		print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}a {padding: 5px 5px;font-size:20px; padding:4px; color:6495ED;} a:hover,a:focus {color: #999999;text-decoration: none;cursor: pointer;}</style><body><br><br><br><center>设备正在尝试折腾PS4...<br>pppwn成功后，请等待5秒钟刷新主页面。<br><br>如果启用GoldHEN检测<br>首次pppwn应等待10秒以便GoldHEN与设备通信。<br><br><a href=index.php>重新加载本页面</a></center></body></html>");
		exec('sudo bash /boot/firmware/PPPwn/run_web.sh force > /dev/null 2>&1 &');
		exit;
	}
}

if (isset($_POST['reset'])){
	exec('sudo rm /tmp/ps4alreadypwned.txt > /dev/null 2>&1 &');
	sleep(1);
	header("Location: index.php");
	exit;
}

if (isset($_POST['reboot'])){
	sleep(1);
	print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}a {padding: 5px 5px;font-size:20px; padding:4px; color:6495ED;} a:hover,a:focus {color: #999999;text-decoration: none;cursor: pointer;}</style><body><br><br><br><center>设备正在重启...<br><br><a href=index.php>重新加载页面</a></center></body></html>");
	exec('sudo reboot > /dev/null 2>&1 &');
	exit;
}

if (isset($_POST['shutdown'])){
	sleep(1);
	print("<html><head><title>穷-折腾</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><style>body{user-select: none;-webkit-user-select: none;background-color: #0E0E14;color: #B6B6B6;font-family: Arial;font-size:20px;}</style><body><br><br><br><center>设备正在关机！</center></body></html>");
	exec('sudo poweroff > /dev/null 2>&1 &');
	exit;
}

if (isset($_POST['payloads'])){
	sleep(1);
	header("Location: payloads.php");
	exit;
}

if (isset($_POST['pconfig'])){
	sleep(1);
	header("Location: pconfig.php");
	exit;
}


$cmd = 'sudo cat /boot/firmware/PPPwn/config.sh';
exec($cmd ." 2>&1", $data, $ret);
if ($ret == 0){
foreach ($data as $x) {
   if (str_starts_with($x, 'CPPMETHOD')) {
      $cppmethod = (explode("=", str_replace("\"", "", $x))[1]);
   }
   elseif (str_starts_with($x, 'INTERFACE')) {
      $interface = (explode("=", str_replace("\"", "", $x))[1]);
   }
   elseif (str_starts_with($x, 'FIRMWAREVERSION')) {
      $firmware = (explode("=", str_replace("\"", "", $x))[1]);
   }
   elseif (str_starts_with($x, 'USBETHERNET')) {
      $usbether = (explode("=", $x)[1]);
   }
   elseif (str_starts_with($x, 'STAGE2METHOD')) {
      $stage2method = (explode("=", str_replace("\"", "", $x))[1]);
   }   
   elseif (str_starts_with($x, 'SOURCEIPV6')) {
      $sourceip = (explode("=", str_replace("\"", "", $x))[1]);
   }
   elseif (str_starts_with($x, 'CUSTOMIPV6')) {
      $customip = (explode("=", str_replace("\"", "", $x))[1]);
   }   
   elseif (str_starts_with($x, 'DETECTMODE')) {
      $detectmode = (explode("=", str_replace("\"", "", $x))[1]);
   }   
   elseif (str_starts_with($x, 'PPPOECONN')) {
      $pppoeconn = (explode("=", $x)[1]);
   }
   elseif (str_starts_with($x, 'PPDBG')) {
      $ppdbg = (explode("=", $x)[1]);
   }
   elseif (str_starts_with($x, 'PWNAUTORUN')) {
      $pwnautorun = (explode("=", $x)[1]);
   }
   elseif (str_starts_with($x, 'TIMEOUT')) {
      $timeout = (explode("=", str_replace("\"", "", $x))[1]);
   }
}
}else{
   $cppmethod = "3";	
   $interface = "eth0";
   $firmware = "11.00";
   $usbether = "false";
   $stage2method = "flow";
   $sourceip = "2";
   $customip = "9f9f:41ff:9f9f:41ff";
   $detectmode = "2";
   $pppoeconn = "true";
   $pwnautorun = "false";
   $timeout = "5m";
   $ppdbg = "false";
}


if (empty($cppmethod)){ $cppmethod = "3";}
if (empty($interface)){ $interface = "eth0";}
if (empty($firmware)){ $firmware = "11.00";}
if (empty($usbether)){ $usbether = "false";}
if (empty($stage2method)){ $stage2method = "flow";}
if (empty($sourceip)){ $sourceip = "2";}
if (empty($customip)){ $customip = "9f9f:41ff:9f9f:41ff";}
if (empty($detectmode)){ $detectmode = "2";}
if (empty($pppoeconn)){ $pppoeconn = "true";}
if (empty($pwnautorun)){ $pwnautorun = "false";}
if (empty($timeout)){ $timeout = "5m";}
if (empty($ppdbg)){ $ppdbg = "false";}


print("<html> 
<head>
<title>穷-折腾</title>
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<style>

body {
	user-select: none;
    -webkit-user-select: none;
    background-color: #0E0E14;
    color: #B6B6B6;
    font-family: Arial;
}

select {
    background: #454545;
	color: #FFFFFF;
	padding: 3px 5px;
    border-radius: 3px;
	border: 1px solid #6495ED;
}


input[type=text] {
    background: #454545;
	color: #FFFFFF;
	padding: 5px 5px;
    border-radius: 3px;
	border: 1px solid #6495ED;
}

a:active,a:hover,
a:focus {
    outline: 0;
    border: none;
	color: #999999;
    text-decoration: none;
    cursor: pointer;
}

a {
	font-size:16px;
	text-decoration: none;
	color:6495ED;
}

button {
    border: 1px solid #6495ED;
    color: #FFFFFF;
    background: #454545;
    padding: 10px 20px;
    margin-bottom:12px;
    border-radius: 3px;
}

button:hover {
    background: #999999;
}

label[id=pwngreen] {
    border: 2px solid #6495ED;
    color: #FFFFFF;
    background: #4CC417;
    padding: 5px 10px;
    margin-bottom:6px;
    border-radius: 4px;
	font-size: 16px;
}

label[id=pwnred] {
    border: 2px solid #6495ED;
    color: #FFFFFF;
    background: #E30B5D;
    padding: 5px 10px;
    margin-bottom:6px;
    border-radius: 4px;
	font-size: 16px;
}

input:focus {
    outline:none;
}

label {
    padding: 5px 5px;
}

input[type=checkbox] {
    position: relative;
    cursor: pointer;
}

input[type=checkbox]:before {
    content: \"\";
    display: block;
    position: absolute;
    width: 17px;
    height: 17px;
    top: 0;
    left: 0;
    background-color:#e9e9e9;
}

input[type=checkbox]:checked:before {
    content: \"\";
    display: block;
    position: absolute;
    width: 17px;
    height: 17px;
    top: 0;
    left: 0;
    background-color:#1E80EF;
}

input[type=checkbox]:checked:after {
    content: \"\";
    display: block;
    width: 3px;
    height: 8px;
    border: solid white;
    border-width: 0 2px 2px 0;
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
    position: absolute;
    top: 2px;
    left: 6px;
}	
	
.logger {
    display: none; 
    position: fixed; 
    z-index: 1; 
    padding-top: 100px; 
    padding-bottom: 100px;
    left: 0;
    top: 0;
    width: 100%; 
    height: 66%; 
    overflow-x:hidden;
    overflow-y:hidden;
    background-color: #00000000;
}


.logger-content {
    position: relative;
    background-color: #0E0E14;
    margin: auto;
    padding: 0;
    border: 1px solid #6495ED;
    width: 80%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
}


@-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
}

@keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
}

.close {
    color: #6495ED;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #999999;
    text-decoration: none;
    cursor: pointer;
}

.logger-header {
    padding: 2px 8px;
    background-color: #0E0E14;
    color: 0E0E14;
}

.logger-body 
{
    padding: 2px 8px;
}

textarea {
    resize: none;
    border: none;
    background-color: #0E0E14;
    color: #FFFFFF;
    box-sizing:border-box;
    height: 100%;
    width: 100%;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;    
    box-sizing: border-box;         
}

label[id=pwnlog] {
    padding: 5px 5px;
	font-size:14px; 
	padding:4px; 
	color:6495ED;
}

label[id=pwnlog]:hover,
label[id=pwnlog]:focus {
    color: #999999;
    text-decoration: none;
    cursor: pointer;
}

label[id=argslog] {
    padding: 5px 5px;
	font-size:14px; 
	padding:4px; 
	color:6495ED;
}

label[id=argslog]:hover,
label[id=argslog]:focus {
    color: #999999;
    text-decoration: none;
    cursor: pointer;
}

label[id=help] {
    padding: 5px 5px;
	font-size:16px; 
	padding:4px; 
	color:6495ED;
}

label[id=help]:hover,
label[id=help]:focus {
    color: #999999;
    text-decoration: none;
    cursor: pointer;
}

div[id=help]{
    height:100%;
    overflow:auto;
    overflow-x:hidden;
	scrollbar-color: #6495ED #0E0E14;
    scrollbar-width: thin;
}

</style>
<script>
var fid;
if (window.history.replaceState) {
   window.history.replaceState(null, null, window.location.href);
}

function startLog(lf) {
   fid = setInterval(updateLog, 2000, lf);
}

function stopLog() {
  clearInterval(fid);
}

function updateLog(f) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/' + f);
	xhr.setRequestHeader('Cache-Control', 'no-cache');
	xhr.responseType = \"text\";
	xhr.onload = () => {
	if (!xhr.responseURL.includes(f)) {
	xhr.abort();
	return;
	}
	if (xhr.readyState === xhr.DONE) {
    if (xhr.status === 200) {
	document.getElementById(\"text_box\").value = xhr.responseText;
	var textarea = document.getElementById('text_box');
	textArea.createTextRange().scrollIntoView(false);
	}
  }
};
xhr.send();
}

function setEnd() {
	if (navigator.userAgent.includes('PlayStation 4')) {
		let name = document.getElementById(\"plist\");
		name.focus();
		name.selectionStart = name.value.length;
		name.selectionEnd = name.value.length;	
	}
}
</script>
</head>
<body>
<center>

<div id=\"pwnlogger\" class=\"logger\">
<div class=\"logger-content\">
<div class=\"logger-header\">
<a href=\"javascript:void(0);\" style=\"text-decoration:none;\"><span class=\"close\">&times;</span></a></div>
<div class=\"logger-body\">
</div></div></div>
<br>
<form method=\"post\"><button name=\"payloads\">Payloads</button> &nbsp; ");


print("<button name=\"pconfig\">折腾模式选项</button> &nbsp; <button name=\"reset\">刷新折腾状态</button> &nbsp; <button name=\"force\">强制折腾</button> &nbsp; <button name=\"reboot\">重启盒子</button> &nbsp; <button name=\"shutdown\"><font color=\"#E30B5D\">关闭盒子</button>
</form>
</center><table align=center><td><form method=\"post\">");



print("<select name=\"cppmethod\">");
for($x =1; $x<=4;$x++)
{
   if ($cppmethod == $x)
   {
	   print("<option value=\"".$x."\" selected>".$cppm[$x-1]."</option>");
   }else{
	   print("<option value=\"".$x."\">".$cppm[$x-1]."</option>");
   }
} 
print("</select><label for=\"cppmethod\">&nbsp; 折腾模式选择 (1=v1.0, 最快速度, 旧IPv6)</label><br><br>");



print("<select name=\"firmware\">");
foreach ($firmwares as $fw) {
if ($firmware == $fw)
{
	print("<option value=\"".$fw."\" selected>".$fw."</option>");
}else{
	print("<option value=\"".$fw."\">".$fw."</option>");
}
}
print("</select><label for=\"firmware\">&nbsp; 主机系统版本 (GoldHEN适用版本9.00, 9.60, 10.00, 10.01, 10.50, 10.70, 10.71, 11.00)</label><br><br>");



print("<select name=\"stage2method\">");
foreach ($stage2jail as $s2m) {
if ($stage2method == $s2m)
{
	print("<option value=\"".$s2m."\" selected>".$s2m."</option>");
}else{
	print("<option value=\"".$s2m."\">".$s2m."</option>");
}
}
print("</select><label for=\"stage2method\">&nbsp; 第二阶段选项，Goldhen只适用上面几个版本(BestPig只适用于10.50)</label><br><br>");



print("<select name=\"detectmode\">");
for($x =1; $x<=4;$x++)
{
   if ($detectmode == $x)
   {
	   print("<option value=\"".$x."\" selected>".$detectm[$x-1]."</option>");
   }else{
	   print("<option value=\"".$x."\">".$detectm[$x-1]."</option>");
   }
} 
print("</select><label for=\"detectmode\">&nbsp; 自动折腾检测模式 (不支持HEN检测)</label><br><br>");



if ($cppmethod !== "1")
{
if (($cppmethod == "3") && ($sourceip == "3")){ $sourceip = "2";}
if ($sourceip == "1") {
$customipd = "4141:4141:4141:4141";
}
else {
$customipd = "9f9f:41ff:9f9f:41ff";
}

print("<select name=\"sourceip\">");
for($x =1; $x<=3;$x++)
{
   if ($sourceip == $x)
   {
	   print("<option value=\"".$x."\" selected>".$sourceipv6[$x-1]."</option>");
   }else{
	   print("<option value=\"".$x."\">".$sourceipv6[$x-1]."</option>");
   }
} 
print("</select><label for=\"sourceip\">&nbsp; IPv6选项</label>");

if ($sourceip == "3")
{
print("<label for=\"customip\">&nbsp; = &nbsp; fe80::&nbsp;</label><input size=\"19\" type=\"text\" name=\"customip\" value=\"".$customip."\" style=\"text-align:center; font-size:16px;\"></label>");
}
else
{
print("<input type=\"hidden\" name=\"customip\" value=\"".$customip."\">");
print("<label for=\"customipd\">&nbsp; = &nbsp; fe80::&nbsp;</label><input size=\"19\" type=\"text\" name=\"customipd\" value=\"".$customipd."\" style=\"text-align:center; font-size:16px;\" disabled></label>");
}
print("<br><br>");
}
else {
print("<input type=\"hidden\" name=\"sourceip\" value=\"".$sourceip."\">");
print("<input type=\"hidden\" name=\"customip\" value=\"".$customip."\">");
}



print("<select name=\"timeout\">");
for($x =1; $x<=5;$x++)
{
   if ($timeout == $x."m")
   {
	   print("<option value=\"".$x."m\" selected>".$x." 分钟</option>");
   }else{
	   print("<option value=\"".$x."m\">".$x."分钟</option>");
   }
} 
print("</select><label for=\"timeout\">&nbsp; 如果PPPwn挂起，重启的时间</label><br>");



if ($cppmethod == "1") {
print("<br>");
}



print("<select name=\"interface\">");
$cmd = 'sudo ip link | cut -d " " -f-2 | cut -d ":" -f2-2 ';
exec($cmd ." 2>&1", $idata, $iret);
foreach ($idata as $x) {
$x = trim($x);
if ($x !== "" && $x !== "lo" && $x !== "ppp0" && !str_starts_with($x, "wlan"))
{
if ( $interface ==  $x)
{
print("<option value=\"".$x."\" selected>".$x."</option>");
}else{
print("<option value=\"".$x."\">".$x."</option>");
}
}
}

print("</select><label for=\"interface\">&nbsp; 连接主机的网卡（不插USB网卡选择eth0）</label>");



if (file_exists('/tmp/ps4alreadypwned.txt')){
	$stage2m = file_get_contents('/tmp/ps4alreadypwned.txt');
	if (empty($stage2m)){ $stage2m = $stage2method;}
	print("&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; <label id=\"pwngreen\">".ucfirst($stage2m)." 正在运行?</label><br>");
}else{
	print("&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; <label id=\"pwnred\">".ucfirst($stage2method)." 未运行?</label><br>");
}



$cval = "";
if ($pwnautorun == "true")
{
$cval = "checked";
}
print("<br><input type=\"checkbox\" name=\"pwnautorun\" value=\"".$pwnautorun."\" ".$cval.">
<label for=\"pwnautorun\">&nbsp;开启自动折腾 <font color=\"#FAF884\">(如需在浏览器中强制折腾，请取消勾选)</font></label><br>");



$cval = "";
if ($pppoeconn == "true")
{
$cval = "checked";
}
print("<br><input type=\"checkbox\" name=\"pppoeconn\" value=\"".$pppoeconn."\" ".$cval.">
<label for=\"pppoeconn\">&nbsp;开启管理网页界面 <font color=\"#E30B5D\">(慎重！慎重！慎重！关闭后此页面不会出现，关闭后自动开机折腾，成功后盒子关机)</font></label><br>");



if ($ppdbg == "true")
{
$argslog = "true";
print("<br><input type=\"checkbox\" name=\"ppdbg\" value=\"".$ppdbg."\" checked>
<label for=\"ppdbg\">&nbsp;启用PPPwn调试和查看日志</label> &nbsp; <a href=\"javascript:void(0);\" style=\"text-decoration:none;\"><label id=\"pwnlog\">打开日志查看器</label></a> &nbsp; <a href=\"javascript:void(0);\" style=\"text-decoration:none;\"><label id=\"argslog\">打开参数查看器</label></a><br>");
}
else
{
print("<br><input type=\"checkbox\" name=\"ppdbg\" value=\"".$ppdbg."\">
<label for=\"ppdbg\">&nbsp;启用PPPwn调试和查看日志</label><br>");
}



$cval = "";
if ($usbether == "true")
{
$cval = "checked";
}
print("<br><input type=\"checkbox\" name=\"usbether\" value=\"".$usbether."\" ".$cval.">
<label for=\"usbether\">&nbsp;使用USB网卡连接主机</label><br>");



if ($cppmethod == "1") {
print("<br>");
}



print("<div style=\"text-align:center; font-size:16px; padding:4px;\">
<a href=\"javascript:void(0);\" style=\"text-decoration:none;\"><label id=\"help\">显示帮助</label></a>
</div>");


print("</td></tr><td align=center><button name=\"save\">保存并应用</button></td></tr>
</form>
</td>
</table>
<script>
var logger = document.getElementById(\"pwnlogger\");
var span = document.getElementsByClassName(\"close\")[0];
");


if ($ppdbg == "true")
{
print("var btn = document.getElementById(\"pwnlog\");
btn.onclick = function() {
  logger.style.display = \"block\";
  var lbody = document.getElementsByClassName(\"logger-body\")[0];
  lbody.innerHTML  = '<textarea disabled id=\"text_box\" rows=\"40\"></textarea>';
  startLog('pwn.log');
}
");
print("var btn_args = document.getElementById(\"argslog\");
btn_args.onclick = function() {
  logger.style.display = \"block\";
  var lbody = document.getElementsByClassName(\"logger-body\")[0];
  lbody.innerHTML  = '<textarea disabled id=\"text_box\" rows=\"40\"></textarea>';
  startLog('args.log');
}
");
}


print("var btn1 = document.getElementById(\"help\");
btn1.onclick = function() {
  logger.style.display = \"block\";
  var lbody = document.getElementsByClassName(\"logger-body\")[0];
  lbody.innerHTML  = \"<br><div id='help' style='text-align: left; font-size: 14px;'> <font color='#F28C28'>折腾模式选择</font> - 每个模式运行方式不一样, 1 v1.0对于旧型号折腾速度最快, 2和3支持妖机折腾，其他模式自行尝试.<br><br><font color='#F28C28'>主机系统版本</font> - 主机系统软件版本.<br><br><font color='#F28C28'>第二阶段折腾方式</font> - GoldHen, Hen-vtx, PI and Hen by BestPig.<br><br><font color='#F28C28'>自动折腾检测模式</font> - 检测主机开机并等待网络连接好；检测Goldhen适用于主机待机模式，避免重复折腾<br><br><font color='#F28C28'>源ipv6</font> - 第三项需要手动输入Ipv6<br><br><f启的时间</font> - 折腾程序卡住不动，自动重启折腾程序的时间（不是折腾失败重启时间）.<br><br><font color='#F28C28'>连接主机的网卡</font> - 选连接主机的网卡，不要乱改哦.<br><br><font color='#F28C28'>自动折ont color='#F28C28'>自定义Ipv6</font> - 在设置这个值时要小心，示例 1111:2222:3333:4444，不要漏掉冒号，这个值适用于折腾模式2和4使用.<br><br><font color='#F28C28'>如果PPPwn挂起，重腾</font> - 您必须在浏览器中强制破解或禁用管理页面以启用自动运行.<br><br><font color='#F28C28'>打开管理页面</font> - 关闭后无法再设置管理界面.<br><br><font color='#F28C28'>启用PPPwn调试和查看日志</font> -启用PPPwn的调试输出，以便在折腾后查看结果.<br><br><font color='#F28C28'>使用USB网卡连接主机</font> - 没有用usb网卡不要选.<br><br><font color='#F28C28'>穷的叮当a响联合折腾折腾仅做整理</font> -感谢各位大佬. </center>\";
}

span.onclick = function() {
  logger.style.display = \"none\";
  stopLog();
  var text1 = document.getElementById(\"text_box\");
  text1.value = '';
}

window.onclick = function(event) {
  if (event.target == logger) {
    logger.style.display = \"none\";
	stopLog();
	var text1 = document.getElementById(\"text_box\");
	text1.value = '';
  }
}
");


print("</script>
</body>
</html>");

?>
