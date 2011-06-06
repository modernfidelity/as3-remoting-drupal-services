package {
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.text.TextField;
	
	public class Main extends Sprite
	{
		
		private var gateway:NetConnection;
		private var txt:TextField;
		private var btn:SimpleButton;
		
		public function Main()
		{
			createSimpleView();
		}
		
		public function init():void {
			gateway = new NetConnection();
			gateway.connect("http://www.modernfidelity.co.uk/services/amfphp");
			
			var responder:Responder = new Responder(onResult, onFault);
			
			
			//var arg:String = '429';
			var arg:Array = new Array();
			
			
			
			//gateway.call( "node.get", responder, arg);
			gateway.call( "views.get", responder, 'amfphp_techblog_all','',arg, 0, 10);      
			
			
			
			/*
			string view_name (required)
			View name.
				string display_id (optional)
			A display provided by the selected view.
				array args (optional)
			An array of arguments to pass to the view.
				int offset (optional)
			An offset integer for paging. For example to get item from 6 to 15, pass offset=5 and limit=10.
				int limit (optional)
			A limit integer for paging. For example to get item from 6 to 15, pass offset=5 and limit=10.
				boolean format_output (optional)
			TRUE if view should be formatted, or only the view result returned (FALSE by default).
			*/
		}
		
		public function onResult(responds:Object):void {
			txt.text = "onResult: \n";
			reflect(responds);
		}
		
		public function onFault(responds:Object):void {
			txt.text = "onFault : " +responds.error ;
			reflect(responds);
		}
		
		public function createSimpleView():void {
			txt = new TextField();
			txt.x = txt.y = 10;
			txt.width = 390;
			txt.height = 200;
			txt.border = true;
			
			addChild(txt);
			
			btn = new SimpleButton();
			btn.x = 10;
			btn.y = 220;
			
			btn.upState = createRectangle( 0x00FF00 );       
			btn.overState = createRectangle( 0xFF0000 ); 
			btn.downState = createRectangle( 0x0000FF ); 
			btn.hitTestState = btn.upState; 
			btn.addEventListener( MouseEvent.CLICK, btnClick );       
			addChild(btn);         
		}
		
		private function btnClick(event:MouseEvent):void {
			init();
		} 
		
		private function createRectangle(color:uint):Shape {       
			var rect:Shape = new Shape(  ); 
			rect.graphics.lineStyle( 1, color ); 
			rect.graphics.beginFill( color ); 
			rect.graphics.drawRect(0,0,150,50)
			rect.graphics.endFill();  
			return rect; 
		} 
		
		private function reflect(obj:Object):void{
			for(var i:String in obj){
				txt.appendText("\n"+i+": "+obj[i].node_title);
			}
		}
	}
}
/*
package
{
	
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.net.Responder;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Main extends Sprite
	{
		
		public var dataProvider:Array;
		public var gateway : RemotingConnection;
		public var debugTxt:TextField;
		public var result:Object;
		
		public function Main() 
		{
			
			
			var debugTxt:TextField = new TextField();  
			debugTxt.height = 250;
			debugTxt.width = 300;
			debugTxt.x = 10;
			debugTxt.y = 10;
			
			addChild(debugTxt);
			
			debugTxt.appendText("as3 debug: ");
			
			
			
			var gatewayUrl:String = "http://www.modernfidelity.co.uk/services/amfphp";
			
			gateway = new RemotingConnection(gatewayUrl);
			
			var responder:Responder = new Responder(onResult, onFault);
			
			var arg:String = '429';
			//var arg:String = 'amfphp_techblog_all';
			
			gateway.call( "node.get", responder, arg);
			//gateway.call( "views.get", responder, arg);
			
			
			
		}
		public function onResult( result : Object) : void
		{
			debugTxt.text = "onResult: " + result.title ;
			reflect(result);
		}
		
		public function onFault( fault : String ) : void
		{
			debugTxt.appendText('onFault invoked');
			debugTxt.appendText( fault );
		}
		
		private function reflect(obj:Object):void{
			for(var i:String in obj){
				debugTxt.appendText("\n"+i+": "+obj[i]);
			}
		}
		
		
		
	}
}
*/