package alternativa.physics {
  public class BodyContact {
    private static var poolTop:BodyContact;

    public var body1:Body;
    public var body2:Body;
    public var shapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();

    private var nextInPool:BodyContact;

    public function BodyContact() {
      super();
    }

    public static function create() : BodyContact {
      if(poolTop == null) {
        return new BodyContact();
      }
      var local1:BodyContact = poolTop;
      poolTop = poolTop.nextInPool;
      local1.nextInPool = null;
      return local1;
    }

    public function dispose() : void {
      var local3:ShapeContact = null;
      this.body1 = null;
      this.body2 = null;
      var local1:uint = this.shapeContacts.length;
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.shapeContacts[local2];
        local3.dispose();
        local2++;
      }
      this.shapeContacts.length = 0;
      this.nextInPool = poolTop;
      poolTop = this;
    }

    public function copy(param1:BodyContact) : void {
      this.body1 = param1.body1;
      this.body2 = param1.body2;
      var local2:Vector.<ShapeContact> = param1.shapeContacts;
      var local3:uint = local2.length;
      var local4:int = 0;
      while(local4 < local3) {
        this.shapeContacts[this.shapeContacts.length] = local2[local4];
        local4++;
      }
    }

    public function setShapeContacts(param1:Vector.<ShapeContact>) : void {
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        this.shapeContacts[local3] = param1[local3];
        local3++;
      }
    }
  }
}
