I-Hate-NSLog
============

This customised NSLog can keep my XCode Console neatly. It also supports format continous JSON string.

NSLog's redundant information wasted too much screen area in my XCode. And, every line sticked together makes me hard to fetch importent information. I really hate this kind debug way. 

The Time stamp is not always useful. Mostly, I don't watch the time stamp. In the Time stamp, Date string is absolutly meanless. Who debug a Objective-C project cross days? I know there must be some extremely scenarios need date string, but only for rare project.

##NSLog
		2014-03-21 15:17:24.115 XXX YYYYYYY[4173:1703] Update Message Data - Start
		2014-03-21 15:17:24.125 XXX YYYYYYY[4173:1703] Request String: {"app":"2","usr":"12345","meth":"get_msgs","req":{"udid":"0c314d56cd479ddaaea1ef7eb25ebb49","quan":"1000","dos":"2014-03-21 03:36:59", "doe":"","dop":"2014-03-21 04:17:24"},"sign":"sign_request"}
		2014-03-21 15:17:24.430 XXX YYYYYYY[4173:1703] Response string: {"code":200,"res":{"msgs":[],"dop":"2014-03-21 04:17:22"},"sign":"sign_response"}
		2014-03-21 15:17:24.436 XXX YYYYYYY[4173:1703] Get Messages successful.

##My NSLog    
		[xxxYyyMsgTableViewController.m: 417] - Update Message Data - Start

		[             xxxYyyFunctions.m: 338] - Request String: 
												{											
													"app":"2",
													"usr":"12345",
													"meth":"get_msgs",
													"req":{												
														"udid":"0c314d56cd479ddaaea1ef7eb25ebb49",
														"quan":"1000",
														"dos":"2014-03-21 03:36:59",
														"doe":"",
														"dop":"2014-03-21 04:11:05"
													},
													"sign":"sign_request"
												}

		[             xxxYyyFunctions.m: 358] - Response string: 
												{											
													"code":228,
													"res":{												
														"msgs":[],
														"dop":"2014-03-21 04:11:04"
													},
													"sign":"sign_response"
												}

		[             xxxYyyFunctions.m: 365] - Get Messages successful.
