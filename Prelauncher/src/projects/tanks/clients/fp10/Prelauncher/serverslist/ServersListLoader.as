package projects.tanks.clients.fp10.Prelauncher.serverslist {
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;

  public class ServersListLoader extends EventDispatcher {
    private var url:String;
    private var serversList:Vector.<ServerNode>;
    private var serverPrefix:String = "main.c";

    public function ServersListLoader(url:String, serverPrefix:String) {
      super();
      this.url = url;
      this.serverPrefix = serverPrefix;
    }

    public function loadServersList() : void {
      var urlLoader:URLLoader = new URLLoader();
      var request:URLRequest = new URLRequest(this.url + "?rnd=" + Math.random());
      request.method = URLRequestMethod.GET;
      urlLoader.addEventListener(Event.COMPLETE,this.onServerListLoaded);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
      urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      urlLoader.load(request);
    }

    private function onServerListLoaded(event:Event) : void {
      var name:String = null;
      var serverNumber:int = 0;
      var usersOnline:int = 0;
      var result:Object = JSON.parse(unescape(event.target.data));
      var servers:Object = result["nodes"];
      this.serversList = new Vector.<ServerNode>();
      for(name in servers) {
        if(name.substr(0,this.serverPrefix.length) == this.serverPrefix) {
          serverNumber = parseInt(name.substr(this.serverPrefix.length));
          usersOnline = int(servers[name]["online"]);
          this.serversList.push(new ServerNode(serverNumber,usersOnline));
        }
      }
      dispatchEvent(new ServersListEvent(ServersListEvent.LOADED,this.serversList));
    }

    private function onError(event:Event) : void {
      dispatchEvent(new ServersListEvent(ServersListEvent.ERROR));
    }
  }
}
