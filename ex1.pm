#!usr/bin/perl 
use DBI;
# Переменные для соединения с базой 
my $database = "u9221_main";
my $user = "u9221_main";
my $password = "********";
my $host = "localhost";
my $data_source = "DBI:mysql:database=$database;host=$host";

my $id = '';
my $name = '';
my $phone = '';
my $work_place_id = '';
my $help = '';
my $from_file = '';


#Подключение к серверу MySQL 
my $dbh = DBI ->connect ($data_source, $user, $password)
  or die "Not conneted";


# Отключение от сервера 
$dbh -> disconnect
	or die "Отсоединение не выполнdено: $DBI::errstr\n";
exit;

sub delete_colum {

	my $id_d = shift;

	my $sql = "DELETE FROM telephone_book 
		WHERE id = ?";
	if ($id_d =~ m/\d{1,11}/){
		my $sth = $dbh -> prepare("$sql")
			or die "WRONG_VALUE";
		$sth->execute($id)
			or die "WRONG_VALUE";
		return 1;
	}
	else {return "WRONG_VALUE"; }
}
 
sub update {
	my $id_u = shift;
	my $phone_u = shift;
	my $name_u = shift;
	my $work_place_id_u = shift;
	my @set ;
	return "WRONG_VALUE" unless($id_u =~  m/\d{1,11}/ ) 
}

	if ($name_u =~ m /.{3,50}/ ){
		push @set, "name='$name_u'\n";
	}
	if ($phone_u =~ m/\.{3,15}/) {
		push @set, "phone='$phone_u'\n";
	}
	if ($work_place_id_u =~ m/\d{1,11}/){
		push @set, "work_place_id='$work_place_id_u'\n";
	}

	
	foreach my $one_set (@set){
		if ($one_set){
			my $sql = "
        UPDATE telephone_book 
		  	SET $one_set
		  	WHERE id=? ";
			my $sth =$dbh -> prepare ("$sql")
				or die "WRONG_PARAMS";
			$sth->execute($id_u)
				or die "WRONG_PARAMS";
		}
	}
	return 1;
}

sub show {
	my $id_s = shift;
	my $name_s = shift;
	my $where;

	if ($id_s =~ m/\d{1,11}/){
		$where = "id= ".$id_s;
	}
	elsif ($name_s =~ m/.{3,50}/){
		$where = "name='$name_s'";
	}
	else {
		$where = '1';
	}

	my $sql ="
    SELECT * 
		FROM telephone_book
		WHERE $where ";
	my $str = $dbh->selectall_arrayref("$sql", undef)
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

	if ($name_i =~ m/.{3,50}/, $phone_i =~ m/.{3,15}/){
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

			my $sql = "
        INSERT INTO telephone_book (name,phone,work_place_id)
				VALUES (?,?,?)";
			my $sth =$dbh -> prepare ("$sql")
				or die "WRONG_PARAMS";
			$sth->execute($name_i,$phone_i,$work_place_id_i)
				or die "WRONG_PARAMS";
		}
		else {return "WRONG_PARAMS";}
	}
	return 1;
}
return 1;
