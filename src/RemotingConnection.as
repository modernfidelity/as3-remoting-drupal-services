package
{
	import flash.net.NetConnection;
	
	import flash.net.ObjectEncoding;
	
	public class RemotingConnection extends NetConnection
	{
		public function RemotingConnection( sURL:String )
		{
			objectEncoding = ObjectEncoding.AMF3;
			if (sURL) connect( sURL );
		}
	}
}