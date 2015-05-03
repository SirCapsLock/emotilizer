<?php
//include 'emotilizer_ParseObject.php';
use \Parse\ParseObject;
use \Parse\ParseQuery;
use \Parse\ParseUser;

class EmoticController extends BaseController
{
	public function getEmotion($userID)
	{
		return "HEllo Emo";
	}
	
	public function getFind()
	{
		$query = new ParseQuery("anger");
		$query->equalTo("Synonnym", "attack");
		$results = $query->find();
		echo "Successfully retrieved " . count($results) . " scores.";
		// Do something with the returned ParseObject values
		for ($i = 0; $i < count($results); $i++) 
		{ 
  		$object = $results[$i];
  		echo $object->get('Synonnym');
		}
		
	}	
	public function getFindFinalMood($ObjectId)
	{
		$query = new ParseQuery("HourlyMood");
		$query->equalTo("FacebookId", $ObjectId);
		$results = $query->find();
		//echo "Successfully retrieved " . count($results) . " scores.";
		
		$answer = array();
	
		// Do something with the returned ParseObject values
		for ($i = 0; $i < count($results); $i++) 
		{ 
  		$object = $results[$i];
		
  		$answer["Mood"] = $object->get('CalcMood');
		$answer["UserId"] = $object->get('FacebookId');
		$answer["success"] = true;
		
		}
		return Response::json($answer);	
	}
	
	
	
	public function getUpdateTable($FbId)
	{
		$query = new ParseObject("HourlyMood");
 
		$query->set("CalcMood", $CalcMood);
		$query->set("DateTimeMood",new DateTime());
		$query->set("FacebookId",$FbId);
 	
 		$answer = array();
		try 
		{
  			$query->save();
  			$answer["success"] =true;
  			$answer["object_id"] = $query->getObjectId();
		} 
		catch (ParseException $ex) 
		{  
  		// Execute any logic that should take place if the save fails.
  		// error is a ParseException object with an error code and message.
  		$answer["success"] =false;
  		$answer["object_id"] = $query->getObjectId();
    	}
		return Response::json(answer);	
	}
	
	
	

	public function postSentence($FbId)
	{
		$statement = Input::get('statement');
		$split = array();
		$split = explode(" ",$statement);
		$query = new ParseQuery("WordsTest");
		$result = array();
		$results = $query->find();
		$object = array();
		$adjcolor = 0;
		$advcolor = 0;
			for ($i = 0; $i < count($results); $i++) 
			{
				for($j = 0; $j < count($split); $j++)
				{
					$objectt = $query->equalTo("Word", $split[$j]);
					$object = $results[$i];
					if(count($object) != 0 && $object->get('Type') == "Adjetive" && $object->get('Word') == $split[$j])
					{
							$adjcolor = $object->get('Weight');
					}
					else
					{
						if(count($object) != 0 && $object->get('Type') == "Adverb" && $object->get('Word') == $split[$j]) 
						{
							$advcolor = $object->get('Weight');
						}		
						else 
						{
							if(count($object) != 0 && $object->get('Type') == "Noun")
								$stype = $object->get('SubType');
								
						}
					}
				}
			}
			
			if($adjcolor == 0 )
			{
				return Response::json($result);
			}
			else
			{
				if(($adjcolor >= 1 && $adjcolor <= 3) )
				{
					$result["color"]= $adjcolor+$advcolor;
					if($result["color"] >= 3)
					$result["color"]= 3;
					$NewColor = new ParseObject("ColorValue");
						$NewColor->set("Color", $adjcolor+$advcolor);
						$NewColor->set("FbId", $FbId);

						try {
						  $NewColor->save();
						  //echo 'New object created with objectId: ' . $NewColor->getObjectId();
						} catch (ParseException $ex) {  
						  // Execute any logic that should take place if the save fails.
						  // error is a ParseException object with an error code and message.
						  //echo 'Failed to create new object, with error message: ' + $ex->getMessage();
						}
						
					return Response::json($result);
				}
				else
				{
					
					if(($adjcolor >= 4 && $adjcolor <= 6) )
					{
						
						$result["Adjcolor"]= $adjcolor+$advcolor;
						if($result["Adjcolor"] >= 6)
						$result["Adjcolor"] = 6;
						
						$NewColor = new ParseObject("ColorValue");
						$NewColor->set("Color", $adjcolor+$advcolor);
						$NewColor->set("FbId", $FbId);
						try {
						  $NewColor->save();
						  //echo 'New object created with objectId: ' . $NewColor->getObjectId();
						} catch (ParseException $ex) {  
						  // Execute any logic that should take place if the save fails.
						  // error is a ParseException object with an error code and message.
						 //echo 'Failed to create new object, with error message: ' + $ex->getMessage();
						}
						
						return Response::json($result);	
					}
					else
					{
						if(($adjcolor >= 7 && $adjcolor <= 9) )
					{
						
						$result["Adjcolor"]= $adjcolor+$advcolor;
						if($result["Adjcolor"] >= 9)
						$result["Adjcolor"] = 9;
						
						$NewColor = new ParseObject("ColorValue");
						$NewColor->set("Color", $adjcolor+$advcolor);
						$NewColor->set("FbId", $FbId);
						try {
						  $NewColor->save();
						  //echo 'New object created with objectId: ' . $NewColor->getObjectId();
						} catch (ParseException $ex) {  
						  // Execute any logic that should take place if the save fails.
						  // error is a ParseException object with an error code and message.
						 //echo 'Failed to create new object, with error message: ' + $ex->getMessage();
						}
						
						return Response::json($result);	
					}	
					}	
				} 
			}
		
	
	
	}


	public function getMood($FbId)
	{
		$query = new ParseQuery("ColorValue");
		$query->equalTo("FbId", $FbId)->limit(10);
		$results = $query->find();
		$avgarr = array();
		$total = 0;
		for ($i = 0; $i < count($results); $i++) { 
		  $object = $results[$i];
		  $total += $object->get('Color');
		}
		$avg = $total/10;
		$avgarr["average"] = $avg;
		$avgarr["FacebookId"] = $FbId;
		return Response::json($avgarr)->header('Access-Control-Allow-Origin', '*');
	
	}

}

?>