package alternativa.engine3d.loaders.collada {
  use namespace collada;

  public class DaeVisualScene extends DaeElement {
    public var nodes:Vector.<DaeNode>;

    public function DaeVisualScene(param1:XML, param2:DaeDocument) {
      super(param1,param2);
      this.constructNodes();
    }

    public function constructNodes() : void {
      var local4:DaeNode = null;
      var local1:XMLList = data.node;
      var local2:int = int(local1.length());
      this.nodes = new Vector.<DaeNode>(local2);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = new DaeNode(local1[local3],document,this);
        if(local4.id != null) {
          document.nodes[local4.id] = local4;
        }
        this.nodes[local3] = local4;
        local3++;
      }
    }
  }
}
