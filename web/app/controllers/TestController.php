<?php

use \Parse\ParseObject;

class TestController extends BaseController
{
	public function getTest()
	{
		$object = ParseObject::create('SomethingCrazy');
		
		return "Testing 1 2 3";
	}
	
	public function postExplode($fbId)
	{
		$statement = "I hate everybody";
		$pieces = explode(" ", $statement);
		for($i = 0; $i < count($pieces); $i++)
		{
			
		}
	}
	
	public function getMood()
	{
		$result["success"] = true;
		
		return Response::json($result)->header('Access-Control-Allow-Origin', '*');	
	}
}

?>