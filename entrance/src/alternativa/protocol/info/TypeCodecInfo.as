package alternativa.protocol.info {
  import flash.utils.getQualifiedClassName;

  public class TypeCodecInfo extends CodecInfo {
    private var _type:Class;

    public function TypeCodecInfo(param1:Class, param2:Boolean) {
      super(param2);
      this._type = param1;
    }

    public function get type() : Class {
      return this._type;
    }

    override public function toString() : String {
      return "[TypeCodecInfo " + super.toString() + " type=" + getQualifiedClassName(this.type);
    }
  }
}
