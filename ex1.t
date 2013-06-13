#!/usr/bin/perl

use lib '/home/u9221/share/perl5/';
use Test::More tests => 12;


require_ok("ex1.pm");




{
$phone="+7987654321";
$name="Sylvester Stallone"; 
$work_place_id = "1";
ok (&insert($phone, $name, $work_place_id) eq "1", "function insert() run right");
}

{
$phone="+7987654321";
$name="Arnold Schwarzenegger"; 
$work_place_id = "sdf";
ok (&insert($phone, $name, $work_place_id) eq "WRONG_PARAMS", "function insert() run  with WRONG_PARAMS ");
}


{
$id=81;
ok (&delete_colum($id) eq "1", "function delete_colum() run right ");
$id=asd;
ok (&delete_colum($id) eq "WRONG_VALUE", "function delete_colum() run with WRONG_VALUE ");
}


{
$id = "91";
$phone = "+7829381902";
$name = "Chuck Norris";
$work_place_id = "2";
ok (&update($id, $phone, $name, $work_place_id) eq "1", "function update() run right");
ok (&update($id, $phone, $name) eq "1", "function update() run right");
ok (&update($id, $phone) eq "1", "function update() run right");
}

{
$id = "101";
$name = "Steven Seagal";
ok (&show($id, $name) eq "1", "function show() run right");
ok (&show($id) eq "1", "function show() run right");
ok (&show($name) eq "1", "function show() run right");
ok (&show() eq "1", "function show() run right");
}
