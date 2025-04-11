package alternativa.tanks.models.tank {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  internal class FakeUserObject implements IGameObject {
    private var _id:Long;

    public function FakeUserObject() {
      super();
      this._id = Long.getLong(Math.random() * int.MAX_VALUE,Math.random() * int.MAX_VALUE);
    }

    [Obfuscation(rename="false")]
    public function get id() : Long {
      return this._id;
    }

    [Obfuscation(rename="false")]
    public function get name() : String {
      return "";
    }

    [Obfuscation(rename="false")]
    public function get gameClass() : IGameClass {
      return null;
    }

    [Obfuscation(rename="false")]
    public function get space() : ISpace {
      return null;
    }

    [Obfuscation(rename="false")]
    public function hasModel(param1:Class) : Boolean {
      return false;
    }

    [Obfuscation(rename="false")]
    public function adapt(param1:Class) : Object {
      return null;
    }

    [Obfuscation(rename="false")]
    public function event(param1:Class) : Object {
      return null;
    }
  }
}
