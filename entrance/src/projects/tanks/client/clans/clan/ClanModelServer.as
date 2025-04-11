package projects.tanks.client.clans.clan {
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

  public class ClanModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _acceptId:Long = Long.getLong(604314745,-105798717);
    private var _accept_userIdCodec:ICodec;
    private var _addId:Long = Long.getLong(1902342915,677739462);
    private var _add_userIdCodec:ICodec;
    private var _addInClanByUidId:Long = Long.getLong(1703252332,-1020199032);
    private var _addInClanByUid_uidCodec:ICodec;
    private var _checkUidId:Long = Long.getLong(925885936,795088419);
    private var _checkUid_uidCodec:ICodec;
    private var _rejectId:Long = Long.getLong(604314746,382952026);
    private var _reject_userIdCodec:ICodec;
    private var _rejectAllId:Long = Long.getLong(1362304089,-1090734311);
    private var _removeUserFromClanId:Long = Long.getLong(537442486,-138480918);
    private var _removeUserFromClan_userIdCodec:ICodec;
    private var _revokeId:Long = Long.getLong(604314746,383319361);
    private var _revoke_userIdCodec:ICodec;
    private var _userLeavesClanId:Long = Long.getLong(1199890940,823346440);
    private var model:IModel;

    public function ClanModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._accept_userIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._add_userIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._addInClanByUid_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._checkUid_uidCodec = this.protocol.getCodec(new TypeCodecInfo(String,false));
      this._reject_userIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._removeUserFromClan_userIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._revoke_userIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function accept(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._accept_userIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._acceptId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function add(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._add_userIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._addId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function addInClanByUid(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._addInClanByUid_uidCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._addInClanByUidId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function checkUid(param1:String) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._checkUid_uidCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._checkUidId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function reject(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._reject_userIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._rejectId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function rejectAll() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._rejectAllId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }

    public function removeUserFromClan(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._removeUserFromClan_userIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._removeUserFromClanId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function revoke(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._revoke_userIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._revokeId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function userLeavesClan() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._userLeavesClanId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
