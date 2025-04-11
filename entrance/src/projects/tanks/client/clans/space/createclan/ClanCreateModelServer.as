package projects.tanks.client.clans.space.createclan {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class ClanCreateModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _createClanId:Long = Long.getLong(153047394,1401385547);
    private var _createClan_nameCodec:ICodec;
    private var _createClan_tagCodec:ICodec;
    private var _createClan_flagIdCodec:ICodec;
    private var _validateNameId:Long = Long.getLong(940455925,-1899445316);
    private var _validateName_nameCodec:ICodec;
    private var _validateTagId:Long = Long.getLong(445979284,1324195135);
    private var _validateTag_tagCodec:ICodec;
    private var model:IModel;

    public function ClanCreateModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._createClan_nameCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._createClan_tagCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._createClan_flagIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._validateName_nameCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._validateTag_tagCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
    }

    public function createClan(param1:String, param2:String, param3:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._createClan_nameCodec.encode(this.protocolBuffer,param1);
      this._createClan_tagCodec.encode(this.protocolBuffer,param2);
      this._createClan_flagIdCodec.encode(this.protocolBuffer,param3);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local4:SpaceCommand = new SpaceCommand(Model.object.id,this._createClanId,this.protocolBuffer);
      var local5:IGameObject = Model.object;
      var local6:ISpace = local5.space;
      local6.commandSender.sendCommand(local4);
      this.protocolBuffer.optionalMap.clear();
    }

    public function validateName(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._validateName_nameCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._validateNameId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function validateTag(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._validateTag_tagCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._validateTagId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
