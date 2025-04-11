package alternativa.engine3d.loaders.collada {
  import flash.utils.Dictionary;

  use namespace collada;

  public class DaeInstanceController extends DaeElement {
    public var node:DaeNode;
    public var topmostJoints:Vector.<DaeNode>;

    public function DaeInstanceController(param1:XML, param2:DaeDocument, param3:DaeNode) {
      super(param1,param2);
      this.node = param3;
    }

    override protected function parseImplementation() : Boolean {
      var local1:DaeController = this.controller;
      if(local1 != null) {
        this.topmostJoints = local1.findRootJointNodes(this.skeletons);
        if(this.topmostJoints != null && this.topmostJoints.length > 1) {
          this.replaceNodesByTopmost(this.topmostJoints);
        }
      }
      return this.topmostJoints != null;
    }

    private function replaceNodesByTopmost(param1:Vector.<DaeNode>) : void {
      var local2:int = 0;
      var local3:DaeNode = null;
      var local4:DaeNode = null;
      var local5:int = int(param1.length);
      var local6:Dictionary = new Dictionary();
      local2 = 0;
      while(local2 < local5) {
        local3 = param1[local2];
        local4 = local3.parent;
        while(local4 != null) {
          if(Boolean(local6[local4])) {
            ++local6[local4];
          } else {
            local6[local4] = 1;
          }
          local4 = local4.parent;
        }
        local2++;
      }
      local2 = 0;
      while(local2 < local5) {
        local3 = param1[local2];
        while(true) {
          local4 = local3.parent;
          if(!(local4 != null && local6[local4] != local5)) {
            break;
          }
          local3 = local3.parent;
        }
        param1[local2] = local3;
        local2++;
      }
    }

    private function get controller() : DaeController {
      var local1:DaeController = document.findController(data.@url[0]);
      if(local1 == null) {
        document.logger.logNotFoundError(data.@url[0]);
      }
      return local1;
    }

    private function get skeletons() : Vector.<DaeNode> {
      var local2:Vector.<DaeNode> = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:XML = null;
      var local6:DaeNode = null;
      var local1:XMLList = data.skeleton;
      if(local1.length() > 0) {
        local2 = new Vector.<DaeNode>();
        local3 = 0;
        local4 = int(local1.length());
        while(local3 < local4) {
          local5 = local1[local3];
          local6 = document.findNode(local5.text()[0]);
          if(local6 != null) {
            local2.push(local6);
          } else {
            document.logger.logNotFoundError(local5);
          }
          local3++;
        }
        return local2;
      }
      return null;
    }

    public function parseSkin(param1:Object) : DaeObject {
      var local2:DaeController = this.controller;
      if(local2 != null) {
        local2.parse();
        return local2.parseSkin(param1,this.topmostJoints,this.skeletons);
      }
      return null;
    }
  }
}
