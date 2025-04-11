package alternativa.physics.contactislands {
  import alternativa.physics.BodyContact;
  import alternativa.physics.PhysicsScene;
  import alternativa.physics.QuickUnionFind;
  import alternativa.utils.clearDictionary;
  import flash.utils.Dictionary;

  public class IslandsGenerator {
    public const contactIslands:Vector.<ContactIsland> = new Vector.<ContactIsland>();

    private const contactIslandsByRootId:Dictionary = new Dictionary();
    private const uf:QuickUnionFind = new QuickUnionFind();

    private var physicsScene:PhysicsScene;

    public function IslandsGenerator(param1:PhysicsScene) {
      super();
      this.physicsScene = param1;
    }

    public function generate(param1:Vector.<BodyContact>, param2:int) : void {
      this.createUnions(param1,param2);
      this.createIslands(param1);
    }

    private function createUnions(param1:Vector.<BodyContact>, param2:int) : void {
      var local5:BodyContact = null;
      this.uf.init(param2);
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(local5.body1.movable && local5.body2.movable) {
          this.uf.union(local5.body1.id,local5.body2.id);
        }
        local4++;
      }
    }

    private function createIslands(param1:Vector.<BodyContact>) : void {
      var local6:BodyContact = null;
      var local7:int = 0;
      var local8:ContactIsland = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local6 = param1[local3];
        if(local6.body1.movable) {
          local7 = this.uf.root(local6.body1.id);
        } else {
          local7 = this.uf.root(local6.body2.id);
        }
        local8 = this.contactIslandsByRootId[local7];
        if(local8 == null) {
          local8 = ContactIsland.create();
          this.contactIslands[this.contactIslands.length] = local8;
          this.contactIslandsByRootId[local7] = local8;
        }
        local8.bodyContacts[local8.bodyContacts.length] = local6;
        local3++;
      }
      var local4:int = int(this.contactIslands.length);
      var local5:int = 0;
      while(local5 < local4) {
        local8 = this.contactIslands[local5];
        local8.init(this.physicsScene);
        local5++;
      }
      clearDictionary(this.contactIslandsByRootId);
    }

    public function clear() : void {
      var local3:ContactIsland = null;
      var local1:int = int(this.contactIslands.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.contactIslands[local2];
        local3.dispose();
        local2++;
      }
      this.contactIslands.length = 0;
    }
  }
}
