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


# connect
my $dbh = DBI->connect("DBI:mysql:database=db2;host=localhost", "joe", "guessme", {'RaiseError' => 1});

# execute INSERT query
my $rows = $dbh->do("INSERT INTO users (id, username, country) VALUES (4, 'jay', 'CZ')");
print "$rows row(s) affected ";

# execute SELECT query
my $sth = $dbh->prepare("SELECT username, country FROM users");
$sth->execute();

# iterate through resultset
# print values
while(my $ref = $sth->fetchrow_hashref()) {
    print "User: $ref-> ";
    print "Country: $ref-> ";
    print "---------- ";
}

# clean up
$dbh->disconnect();