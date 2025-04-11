package platform.loading.codecs {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.IDataInput;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsData;
  import platform.client.core.general.spaces.loading.modelconstructors.ModelData;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class ObjectsDataCodec implements ICodec {
    private var modelDataCodec:ModelDataCodec = new ModelDataCodec();
    private var longCodec:ICodec;
    private var gameTypeRegistry:GameTypeRegistry;
    private var spaceRegistry:SpaceRegistry;

    public function ObjectsDataCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.modelDataCodec.init(param1);
      this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
      this.gameTypeRegistry = OSGi.getInstance().getService(GameTypeRegistry);
      this.spaceRegistry = OSGi.getInstance().getService(SpaceRegistry);
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      throw new Error("unsupported");
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ObjectsData = new ObjectsData();
      local2.objects = this.decodeObjects(param1);
      local2.modelsData = this.decodeModelsData(param1);
      return local2;
    }

    private function decodeObjects(param1:ProtocolBuffer) : Vector.<IGameObject> {
      var local2:IDataInput = param1.reader;
      var local3:int = int(local2.readInt());
      var local4:Vector.<IGameObject> = new Vector.<IGameObject>(local3);
      var local5:int = 0;
      while(local5 < local3) {
        local4[local5] = this.readObject(param1);
        local5++;
      }
      return local4;
    }

    private function readObject(param1:ProtocolBuffer) : IGameObject {
      var local2:Long = Long(this.longCodec.decode(param1));
      var local3:Long = Long(this.longCodec.decode(param1));
      var local4:ISpace = this.spaceRegistry.currentSpace;
      if(local4.rootObject.id == local2) {
        local4.destroyObject(local2);
      }
      var local5:IGameClass = this.gameTypeRegistry.getClass(local3);
      if(local5 == null) {
        throw new Error("Class not found exception class=" + local3 + ", object=" + local2);
      }
      return local4.createObject(local2,local5,"");
    }

    private function decodeModelsData(param1:ProtocolBuffer) : Vector.<ModelData> {
      var local2:int = int(param1.reader.readInt());
      var local3:Vector.<ModelData> = new Vector.<ModelData>(local2);
      var local4:int = 0;
      while(local4 < local2) {
        local3[local4] = ModelData(this.modelDataCodec.decode(param1));
        local4++;
      }
      return local3;
    }
  }
}
