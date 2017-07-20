## 此文件保存工具
use LWP::UserAgent;
use strict;
use POSIX;
use LWP::ConnCache;
use Unicode::MapUTF8 qw(to_utf8 from_utf8);
use Encode;
use JSON;
require "var_of_sc_robot.pl";

## des：使用百度api分词
## param：{param1：要分的内容； param2：使用的浏览器}
## return：以逗号分隔的词
sub split_word{
    ## 获取参数
	my $con = shift;
	my $browser = shift;
	## 返回的变量
	my $res_w;
	## 构建url，获取概率大于0.8的词
    my $api_url="http://apis.baidu.com/apistore/pullword/words?source=".$con."&param1=0.8&param2=0";
    my $content = get $api_url || return "1";
	## 获取参数
	## get url
	my $response=$browser->get($api_url,"apikey" => "63b303cb88bd0c419065196069174b28");
	unless ($response->is_success){
		print LOGFH "无法获取$api_url -- ",$response->status_line,"\n";
		return "";
	}
	## 解码
	my $content = decode("utf8", $response->content);
	##解json
	my $word_results = JSON->new->utf8->decode($content);
	if($word_results->{errMsg}){
		return "";
	}else{
	    my @word_results = split(/\n/,$content);
		foreach(@word_results){
		    ## 获取以逗号分开
			$res_w.=$_;	
		}
	}
	return $res_w;	
}

## des：分析内容递归遍历
## param：{param1：url； param2：url；param3：使用的浏览器;}
## return：返回内容
sub robot{
	## 获取参数
	my $url = shift;
	my $browser = shift;
	my @urls = shift;  ## 将要抓取的url
    my @usd_urls = shift; ## 已经抓取过的url
	my $response=$browser->get($url);
	unless ($response->is_success){
		print LOGFH "无法获取$url -- ",$response->status_line,"\n";
		return "the_end";
	}
	my $con = decode("utf8", $response->content);
	$con = encode("gb2312", $con);
	## 分析内容
	
	## 递归遍历

	while($con =~ /href=\"(.+?)\"/g){
	    print $1."\n";
	    unless(push_url($1,@usd_urls)){
			push(@urls,$1);
	    }
	}

}
## des：去重添加
## param：{param1：url； param2：已经用过的url@usd_urls}
## return：返回内容,包含返回1不包含返回0
sub push_url{
    my $new_url = shift;
    my @usd_urls = shift;
	my $is_used;
	## 判断是否是base
	if(is_base($new_url)){
		## 判断是否已经遍历过
		foreach(@usd_urls){
			if($_ eq $new_url){
				$is_used=1;
				last;
			}
		}
	}
	return $is_used;
}
# 判断是否是base url下的
sub is_base{
	my $new_url = shift;
	my @base_url = get_base();  ## 可以自定义
	my $is_base;
	foreach(@base_url){
		if($new_url =~ /$_/g){
			$is_base = 1;
			last;
		}
	}
	return $is_base;
}
# 打印环境变量
sub e_path{
	print "Content-type: text/html\n\n";
	print "<font size=+1>Environment</font>\n";
	foreach (sort keys %ENV)
	{
		print "<b>$_</b>: $ENV{$_}<br>\n";
	}

}

1;

