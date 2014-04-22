I-Hate-NSLog
============

This customised NSLog can keep my XCode Console neatly. It also supports format continous JSON string.

NSLog's redundant information wasted too much screen area in my XCode. And, every line sticked together makes me hard to fetch importent information. I really hate this kind debug way. 
##What NSLog has
###Time Stamp
The Time stamp is not always useful. Mostly, I don't watch the time stamp. In the Time stamp, Date string is absolutly meanless. Who debug a Objective-C project cross days? I know there must be some extremely scenarios need date string, but only for rare project. When I start debug app, most log will generated in one minus. String before minute will be useless for me.  

###Project Name
Come on!! I know what I am working on! Please do not repeatly print my project name in each line!!

###Object ID
I agree I am a newbie. But I don't think most sophisticated developers care the Object ID when they debuging.

NSLog wastes 35+[projectName Length] characters in each line!!!

##What I need
###File Name and Line Number
When I debug a little bit bigger project, NSLogs will be marked in every where, different files, different lines. I need to trace back to the file and line I have maked.

###JSON string
I know you can convert JSON String to JSON data to NSDictionary for NSLog. But the format will not be the standard JSON.



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


##How to  
Add following lines into your project's <project>-Prefix.pch  

		#import "Log.h"
		#ifdef DEBUG_MODE
		#define NSLog( args ... )      _Log(@"", __FILE__, __LINE__, __PRETTY_FUNCTION__, args);
		#define NSLogObj( args ... )   LogObj(@"", __FILE__, __LINE__, __PRETTY_FUNCTION__, args);
		#else
		#define NSLog( args ... )
		#define NSLogObj( obj ... )
		#endif
		
		#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
		#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
		#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

