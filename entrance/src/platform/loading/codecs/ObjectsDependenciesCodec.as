package platform.loading.codecs {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import alternativa.types.Short;
  import flash.utils.IDataInput;
  import platform.client.core.general.spaces.loading.dispatcher.types.ObjectsDependencies;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceInfo;

  public class ObjectsDependenciesCodec implements ICodec {
    private var gameTypeRegistry:GameTypeRegistry;
    private var resourceRegistry:ResourceRegistry;
    private var longCodec:ICodec;
    private var shortCodec:ICodec;
    private var booleanCodec:ICodec;

    public function ObjectsDependenciesCodec() {
      super();
    }

    public function init(param1:IProtocol) : void {
      var local2:OSGi = OSGi.getInstance();
      this.gameTypeRegistry = local2.getService(GameTypeRegistry);
      this.resourceRegistry = local2.getService(ResourceRegistry);
      this.longCodec = param1.getCodec(new TypeCodecInfo(Long,false));
      this.shortCodec = param1.getCodec(new TypeCodecInfo(Short,false));
      this.booleanCodec = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      throw new Error("unsupported");
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ObjectsDependencies = new ObjectsDependencies();
      local2.callbackId = param1.reader.readInt();
      this.readGameClasses(param1);
      local2.resources = this.readResources(param1);
      return local2;
    }

    private function readGameClasses(param1:ProtocolBuffer) : void {
      var local2:int = int(param1.reader.readInt());
      var local3:int = 0;
      while(local3 < local2) {
        this.decodeAndRegisterGameClass(param1);
        local3++;
      }
    }

    private function decodeAndRegisterGameClass(param1:ProtocolBuffer) : void {
      var local2:Long = Long(this.longCodec.decode(param1));
      var local3:int = int(param1.reader.readInt());
      var local4:Vector.<Long> = new Vector.<Long>(local3);
      var local5:int = 0;
      while(local5 < local3) {
        local4[local5] = Long(this.longCodec.decode(param1));
        local5++;
      }
      this.gameTypeRegistry.createClass(local2,local4);
    }

    private function readResources(param1:ProtocolBuffer) : Vector.<Resource> {
      var local6:Resource = null;
      var local7:Boolean = false;
      var local8:int = 0;
      var local9:int = 0;
      var local10:Long = null;
      var local11:Resource = null;
      var local2:IDataInput = param1.reader;
      var local3:int = int(local2.readInt());
      var local4:Vector.<Resource> = new Vector.<Resource>();
      var local5:int = 0;
      while(local5 < local3) {
        local6 = this.getResource(this.readResourceInfo(param1));
        local7 = !local6.isLazy && local6.status == null;
        if(local7) {
          local4.push(local6);
        }
        local8 = int(local2.readByte());
        local9 = 0;
        while(local9 < local8) {
          local10 = Long(this.longCodec.decode(param1));
          if(local7) {
            local11 = this.resourceRegistry.getResource(local10);
            if(!local11.isLoaded) {
              local6.addDependence(local11);
            }
          }
          local9++;
        }
        local5++;
      }
      return local4;
    }

    private function getResource(param1:ResourceInfo) : Resource {
      var local2:Long = param1.id;
      if(this.resourceRegistry.isRegistered(local2)) {
        return this.resourceRegistry.getResource(local2);
      }
      if(!this.resourceRegistry.isTypeClassRegistered(param1.type)) {
        throw new Error("Unknown resource type");
      }
      var local3:Class = this.resourceRegistry.getResourceClass(param1.type);
      var local4:Resource = Resource(new local3(param1));
      this.resourceRegistry.registerResource(local4);
      return local4;
    }

    private function readResourceInfo(param1:ProtocolBuffer) : ResourceInfo {
      var local2:Long = Long(this.longCodec.decode(param1));
      var local3:int = int(this.shortCodec.decode(param1));
      var local4:Long = Long(this.longCodec.decode(param1));
      var local5:Boolean = Boolean(this.booleanCodec.decode(param1));
      return new ResourceInfo(local3,local2,local4,local5);
    }
  }
}
