## 连接sqlserver数据库
use DBI; 
## ip和端口
my $host = '127.0.0.1,3306'; 
## 数据库名
my $database = 'gShare'; 
## 用户名
my $user = 'sa'; 
## 密码
my $auth = '123456'; 

my $driver="DBI:mysql"; 
my $database="perl_test"; 
my $user="root"; 
my $host="localhost"; 
my $passwd="root"; 
my $rules="alert_rules"; 
my $dbh = DBI->connect("$driver:database=$database;host=$host;user=$user;password=$passwd") 
or die "Can't connect: " . DBI->errstr; 
my $sth=$dbh->prepare("select app_name,receivers from $rules "); 
$sth->execute() or die "Can't prepare sql statement". $sth->errstr; 
my $sth=$dbh->prepare("select app_name,receivers from $rules "); 
$sth->execute() or die "Can't prepare sql statement". $sth->errstr; 
# 打印获取的数据 
while(@recs=$sth->fetchrow_array){ 
print $recs[0].":".$recs[1]."\n"; 
} 
$sth->finish(); 
$dbh->disconnect(); 