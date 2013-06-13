#!/usr/bin/perl
use lib '/home/u9221/share/perl5/';
use Test::More tests => 12;
use CudeInterface; 

use_ok("CudeInterface");
#переменные 
$phone="+7987654321";
$name="Sylvester Stallone"; 
$work_place_id = "1";

#Проверка insert()
{
ok (&insert($phone, $name, $work_place_id) eq "1", "function insert() run right");
$wrong_work_place_id = "sdf";
ok (&insert($phone, $name, $wrong_work_place_id) eq "WRONG_PARAMS", "function insert() run  with WRONG_PARAMS ");
}

#Последний добавленный id 
my $id = &insert_id;

#Проверка show()
{
my $expected_show = $name.' '.$phone.' '.$work_place_id;
my $got_show;

$got_show= &show($id);
$got_show = "@{$got_show->[-1]}[1..3]"; 
is_deeply ($got_show, $expected_show, "function show() run right");

$got_show = &show($name);
$got_show = "@{$got_show->[-1]}[1..3]"; 
is_deeply ($got_show, $expected_show, "function show() run right");

$got_show = &show();
$got_show = "@{$got_show->[-1]}[1..3]";
is_deeply ($got_show, $expected_show, "function show() run right");
}

#Проверка update()
{
$phone = "+7829381902";
$name = "Chuck Norris";
$work_place_id = "2";

ok (&update($id, $phone, $name, $work_place_id) eq "1", "function update() run right");
ok (&update($id, $phone, $name) eq "1", "function update() run right");
ok (&update($id, $phone) eq "1", "function update() run right");
}


#Проверка delite() и удаление проверочных данных 
{
ok (&delete_colum($id) eq "1", "function delete_colum() run right ");

$id=asd;
ok (&delete_colum($id) eq "WRONG_VALUE", "function delete_colum() run with WRONG_VALUE ");
}



