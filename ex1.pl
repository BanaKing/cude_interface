#!usr/bin/perl 

use 5.010;
use DBI;
use Getopt::Long;

# Переменные для соединения с базой 
my $database = "u9221_main";
my $user = "u9221_main";
my $password = "*******";
my $host = "localhost";
my $data_source = "DBI:mysql:database=$database;host=$host";

my $id = '';
my $name = '';
my $phone = '';
my $work_place_id = '';
my $help = '';
my $from_file = '';

&helper() if (@ARGV == 0);

GetOptions ( 
  'id=i' => \$id ,
	'name=s' => \$name,
	'phone=s' => \$phone,
	'from_file=s' => \$from_file,
	'work_place_id=i' => \$work_place_id,
	'help' => \$help 
	)
		or die "WRONG OPTIONS pleace use option '--help' \n" ;

my $command = shift @ARGV;

# Подключение к серверу MySQL 
my $dbh = DBI ->connect ($data_source, $user, $password);
	
# Работа с базой данных

given ($command) { 
	
	when (/^add$/) {
		insert($phone, $name, $work_place_id, $from_file);
		exit;
	}
	when (/^update$/) {
		&update($id, $phone, $name, $work_place_id);
		exit;
	}
	when (/^show$/) {
		show($id, $name);
		exit;
	}
	when (/^delete$/){
		delete_colum($id);
	}
	when (/^help$/) {
		&helper();
		exit;
	}
	when (1==1) {
		print "Insert wrong value \n";
		&helper();
		exit;
	}
}


# Отключение от сервера 
$dbh -> disconnect
	or die "Отсоединение не выполнено: $DBI::errstr\n";
exit;

sub delete_colum {
	my $id_d = shift;
	my $sth = $dbh -> prepare("
	DELETE FROM telephone_book 
	WHERE id = ?")
		or die "WRONG_VALUE";
	$sth->execute($id)
		or die "WRONG_VALUE";
	return 1;
}
 
sub update {
	my $id_u = shift;
	my $phone_u = shift;
	my $name_u = shift;
	my $work_place_id_u = shift;
	my @set ;
	if ($id_u =~  m/\d{1,11}/, $name_u =~ m /.{3,50}/ ){
		push @set, "name='$name_u'\n";
	}
	if ($id_u =~  m/\d{1,11}/, $phone_u =~ m/\.{3,15}/) {
		push @set, "phone='$phone_u'\n";
	}
	if ($id_u =~  m/\d{1,11}/, $work_place_id_u =~ m/\d{1,11}/){
		push @set, "work_place_id='$work_place_id_u'\n";
	}
	foreach my $set (@set){
		if ($set){
			my $str = $dbh->selectall_arrayref("
				UPDATE telephone_book 
				SET $set
				WHERE id=? ", undef, $id_u)
				or die "WRONG_VALUE\n";
		}
	}
	return 1;
}

sub show {
	my $id_s = shift;
	my $name_s = shift;
	if ($id_s =~ m/\d{1,11}/){
		$where = "id= ".$id_s;
	}
	elsif ($name_s =~ m/.{3,50}/){
		$where = "name='$name_s'";
	}
	else {
		$where = '1';
	}
	my $str = $dbh->selectall_arrayref("
		SELECT * 
		FROM telephone_book
		WHERE $where ", undef)
		or die "WRONG_VALUE\n";
	printf "%-4s%-15s%-20s%s\n", "ID", "NAME", "PHONE", "WORK PLACE",;
	foreach  (@$str) {
		printf "%-4s%-15s%-20s%s\n", @$_;
	}
	return 1;
}

sub insert {
	my $phone_i = shift;
	my $name_i = shift;
	my $work_place_id_i = shift;
	my $file_path = shift;
	my @array;
	if ($name_i =~ m/.{3,50}/, $phone_i =~ m/\.{3,15}/){
		push @array, $name_i.";".$phone_i.";".$work_place_id_i."\n";
	}
	if ($file_path) {
		open (FILE, "<", $from_file) 
		or die "cannot open < $from_file: $!";
		push @array , <FILE>;
		close (FILE);
	}
	foreach (@array) {
		if ($_ =~ m /(^(.{3,50});(.{3,15});(\d{1,11})$)/){
			$name_i = $2;
			$phone_i = $3;
			$work_place_id_i = $4;
			my $sth = $dbh -> prepare ("
				INSERT INTO telephone_book (name,phone,work_place_id)
				VALUES (?,?,?)")
				or die "WRONG_PARAMS";
			$sth->execute($name_i,$phone_i,$work_place_id_i)
				or die "WRONG_PARAMS";
		}
		else {return "WRONG_PARAMS";}
	}
	return 1;
}
sub helper {
	open (HELP, "<", 'help') 
		or die "cannot open < help: $!";
	while (<HELP>) { 
		print;
	}
	close (HELP);
	exit;
}
