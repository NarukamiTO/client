package projects.tanks.clients.fp10.Prelauncher.serverslist {
  public class ServerNode {
    public var serverNumber:int;
    public var usersOnline:int;

    public function ServerNode(serverNumber:int, usersOnline:int) {
      super();
      this.serverNumber = serverNumber;
      this.usersOnline = usersOnline;
    }
  }
}
