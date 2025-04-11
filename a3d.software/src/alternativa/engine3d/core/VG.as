package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.geom.ColorTransform;

  use namespace alternativa3d;

  public class VG {
    private static var collector:VG;

    alternativa3d var next:VG;
    alternativa3d var faceStruct:Face;
    alternativa3d var object:Object3D;
    alternativa3d var alpha:Number;
    alternativa3d var blendMode:String;
    alternativa3d var colorTransform:ColorTransform;
    alternativa3d var filters:Array;
    alternativa3d var sorting:int;
    alternativa3d var debug:int = 0;
    alternativa3d var space:int = 0;
    alternativa3d var viewAligned:Boolean = false;
    alternativa3d var tma:Number;
    alternativa3d var tmb:Number;
    alternativa3d var tmc:Number;
    alternativa3d var tmd:Number;
    alternativa3d var tmtx:Number;
    alternativa3d var tmty:Number;
    alternativa3d var boundMinX:Number;
    alternativa3d var boundMinY:Number;
    alternativa3d var boundMinZ:Number;
    alternativa3d var boundMaxX:Number;
    alternativa3d var boundMaxY:Number;
    alternativa3d var boundMaxZ:Number;
    alternativa3d var boundMin:Number;
    alternativa3d var boundMax:Number;
    alternativa3d var boundVertexList:Vertex = Vertex.alternativa3d::createList(8);
    alternativa3d var boundPlaneList:Vertex = Vertex.alternativa3d::createList(6);
    alternativa3d var numOccluders:int;

    public function VG() {
      super();
    }

    alternativa3d static function create(param1:Object3D, param2:Face, param3:int, param4:int, param5:Boolean, param6:Number = 1, param7:Number = 0, param8:Number = 0, param9:Number = 1, param10:Number = 0, param11:Number = 0) : VG {
      var local12:VG = null;
      if(collector != null) {
        local12 = collector;
        collector = collector.alternativa3d::next;
        local12.alternativa3d::next = null;
      } else {
        local12 = new VG();
      }
      local12.alternativa3d::object = param1;
      local12.alternativa3d::alpha = param1.alpha;
      local12.alternativa3d::blendMode = param1.blendMode;
      local12.alternativa3d::colorTransform = param1.colorTransform;
      local12.alternativa3d::filters = param1.filters;
      local12.alternativa3d::faceStruct = param2;
      local12.alternativa3d::sorting = param3;
      local12.alternativa3d::debug = param4;
      if(param5) {
        local12.alternativa3d::viewAligned = true;
        local12.alternativa3d::tma = param6;
        local12.alternativa3d::tmb = param7;
        local12.alternativa3d::tmc = param8;
        local12.alternativa3d::tmd = param9;
        local12.alternativa3d::tmtx = param10;
        local12.alternativa3d::tmty = param11;
      }
      return local12;
    }

    alternativa3d function destroy() : void {
      if(this.alternativa3d::faceStruct != null) {
        this.destroyFaceStruct(this.alternativa3d::faceStruct);
        this.alternativa3d::faceStruct = null;
      }
      this.alternativa3d::object = null;
      this.alternativa3d::viewAligned = false;
      this.alternativa3d::colorTransform = null;
      this.alternativa3d::filters = null;
      this.alternativa3d::numOccluders = 0;
      this.alternativa3d::debug = 0;
      this.alternativa3d::space = 0;
      this.alternativa3d::next = collector;
      collector = this;
    }

    private function destroyFaceStruct(param1:Face) : void {
      if(param1.alternativa3d::processNegative != null) {
        this.destroyFaceStruct(param1.alternativa3d::processNegative);
        param1.alternativa3d::processNegative = null;
      }
      if(param1.alternativa3d::processPositive != null) {
        this.destroyFaceStruct(param1.alternativa3d::processPositive);
        param1.alternativa3d::processPositive = null;
      }
      var local2:Face = param1.alternativa3d::processNext;
      while(local2 != null) {
        param1.alternativa3d::processNext = null;
        param1 = local2;
        local2 = param1.alternativa3d::processNext;
      }
    }

    alternativa3d function calculateAABB(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number) : void {
      this.alternativa3d::boundMinX = 1e+22;
      this.alternativa3d::boundMinY = 1e+22;
      this.alternativa3d::boundMinZ = 1e+22;
      this.alternativa3d::boundMaxX = -1e+22;
      this.alternativa3d::boundMaxY = -1e+22;
      this.alternativa3d::boundMaxZ = -1e+22;
      this.calculateAABBStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      this.alternativa3d::space = 1;
    }

    alternativa3d function calculateOOBB(param1:Object3D) : void {
      var local2:Vertex = null;
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Vertex = null;
      var local10:Vertex = null;
      var local11:Vertex = null;
      var local12:Vertex = null;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Vertex = null;
      var local27:Vertex = null;
      var local28:Vertex = null;
      var local29:Vertex = null;
      if(this.alternativa3d::space == 1) {
        this.alternativa3d::transformStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId,param1.alternativa3d::ma,param1.alternativa3d::mb,param1.alternativa3d::mc,param1.alternativa3d::md,param1.alternativa3d::me,param1.alternativa3d::mf,param1.alternativa3d::mg,param1.alternativa3d::mh,param1.alternativa3d::mi,param1.alternativa3d::mj,param1.alternativa3d::mk,param1.alternativa3d::ml);
      }
      if(!this.alternativa3d::viewAligned) {
        this.alternativa3d::boundMinX = 1e+22;
        this.alternativa3d::boundMinY = 1e+22;
        this.alternativa3d::boundMinZ = 1e+22;
        this.alternativa3d::boundMaxX = -1e+22;
        this.alternativa3d::boundMaxY = -1e+22;
        this.alternativa3d::boundMaxZ = -1e+22;
        this.calculateOOBBStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId,this.alternativa3d::object.alternativa3d::ima,this.alternativa3d::object.alternativa3d::imb,this.alternativa3d::object.alternativa3d::imc,this.alternativa3d::object.alternativa3d::imd,this.alternativa3d::object.alternativa3d::ime,this.alternativa3d::object.alternativa3d::imf,this.alternativa3d::object.alternativa3d::img,this.alternativa3d::object.alternativa3d::imh,this.alternativa3d::object.alternativa3d::imi,this.alternativa3d::object.alternativa3d::imj,this.alternativa3d::object.alternativa3d::imk,this.alternativa3d::object.alternativa3d::iml);
        if(this.alternativa3d::boundMaxX - this.alternativa3d::boundMinX < 1) {
          this.alternativa3d::boundMaxX = this.alternativa3d::boundMinX + 1;
        }
        if(this.alternativa3d::boundMaxY - this.alternativa3d::boundMinY < 1) {
          this.alternativa3d::boundMaxY = this.alternativa3d::boundMinY + 1;
        }
        if(this.alternativa3d::boundMaxZ - this.alternativa3d::boundMinZ < 1) {
          this.alternativa3d::boundMaxZ = this.alternativa3d::boundMinZ + 1;
        }
        local2 = this.alternativa3d::boundVertexList;
        local2.x = this.alternativa3d::boundMinX;
        local2.y = this.alternativa3d::boundMinY;
        local2.z = this.alternativa3d::boundMinZ;
        local3 = local2.alternativa3d::next;
        local3.x = this.alternativa3d::boundMaxX;
        local3.y = this.alternativa3d::boundMinY;
        local3.z = this.alternativa3d::boundMinZ;
        local4 = local3.alternativa3d::next;
        local4.x = this.alternativa3d::boundMinX;
        local4.y = this.alternativa3d::boundMaxY;
        local4.z = this.alternativa3d::boundMinZ;
        local5 = local4.alternativa3d::next;
        local5.x = this.alternativa3d::boundMaxX;
        local5.y = this.alternativa3d::boundMaxY;
        local5.z = this.alternativa3d::boundMinZ;
        local6 = local5.alternativa3d::next;
        local6.x = this.alternativa3d::boundMinX;
        local6.y = this.alternativa3d::boundMinY;
        local6.z = this.alternativa3d::boundMaxZ;
        local7 = local6.alternativa3d::next;
        local7.x = this.alternativa3d::boundMaxX;
        local7.y = this.alternativa3d::boundMinY;
        local7.z = this.alternativa3d::boundMaxZ;
        local8 = local7.alternativa3d::next;
        local8.x = this.alternativa3d::boundMinX;
        local8.y = this.alternativa3d::boundMaxY;
        local8.z = this.alternativa3d::boundMaxZ;
        local9 = local8.alternativa3d::next;
        local9.x = this.alternativa3d::boundMaxX;
        local9.y = this.alternativa3d::boundMaxY;
        local9.z = this.alternativa3d::boundMaxZ;
        local10 = local2;
        while(local10 != null) {
          local10.alternativa3d::cameraX = this.alternativa3d::object.alternativa3d::ma * local10.x + this.alternativa3d::object.alternativa3d::mb * local10.y + this.alternativa3d::object.alternativa3d::mc * local10.z + this.alternativa3d::object.alternativa3d::md;
          local10.alternativa3d::cameraY = this.alternativa3d::object.alternativa3d::me * local10.x + this.alternativa3d::object.alternativa3d::mf * local10.y + this.alternativa3d::object.alternativa3d::mg * local10.z + this.alternativa3d::object.alternativa3d::mh;
          local10.alternativa3d::cameraZ = this.alternativa3d::object.alternativa3d::mi * local10.x + this.alternativa3d::object.alternativa3d::mj * local10.y + this.alternativa3d::object.alternativa3d::mk * local10.z + this.alternativa3d::object.alternativa3d::ml;
          local10 = local10.alternativa3d::next;
        }
        local11 = this.alternativa3d::boundPlaneList;
        local12 = local11.alternativa3d::next;
        local13 = local2.alternativa3d::cameraX;
        local14 = local2.alternativa3d::cameraY;
        local15 = local2.alternativa3d::cameraZ;
        local16 = local3.alternativa3d::cameraX - local13;
        local17 = local3.alternativa3d::cameraY - local14;
        local18 = local3.alternativa3d::cameraZ - local15;
        local19 = local6.alternativa3d::cameraX - local13;
        local20 = local6.alternativa3d::cameraY - local14;
        local21 = local6.alternativa3d::cameraZ - local15;
        local22 = local21 * local17 - local20 * local18;
        local23 = local19 * local18 - local21 * local16;
        local24 = local20 * local16 - local19 * local17;
        local25 = 1 / Math.sqrt(local22 * local22 + local23 * local23 + local24 * local24);
        local22 *= local25;
        local23 *= local25;
        local24 *= local25;
        local11.alternativa3d::cameraX = local22;
        local11.alternativa3d::cameraY = local23;
        local11.alternativa3d::cameraZ = local24;
        local11.alternativa3d::offset = local13 * local22 + local14 * local23 + local15 * local24;
        local12.alternativa3d::cameraX = -local22;
        local12.alternativa3d::cameraY = -local23;
        local12.alternativa3d::cameraZ = -local24;
        local12.alternativa3d::offset = -local4.alternativa3d::cameraX * local22 - local4.alternativa3d::cameraY * local23 - local4.alternativa3d::cameraZ * local24;
        local26 = local12.alternativa3d::next;
        local27 = local26.alternativa3d::next;
        local13 = local2.alternativa3d::cameraX;
        local14 = local2.alternativa3d::cameraY;
        local15 = local2.alternativa3d::cameraZ;
        local16 = local6.alternativa3d::cameraX - local13;
        local17 = local6.alternativa3d::cameraY - local14;
        local18 = local6.alternativa3d::cameraZ - local15;
        local19 = local4.alternativa3d::cameraX - local13;
        local20 = local4.alternativa3d::cameraY - local14;
        local21 = local4.alternativa3d::cameraZ - local15;
        local22 = local21 * local17 - local20 * local18;
        local23 = local19 * local18 - local21 * local16;
        local24 = local20 * local16 - local19 * local17;
        local25 = 1 / Math.sqrt(local22 * local22 + local23 * local23 + local24 * local24);
        local22 *= local25;
        local23 *= local25;
        local24 *= local25;
        local26.alternativa3d::cameraX = local22;
        local26.alternativa3d::cameraY = local23;
        local26.alternativa3d::cameraZ = local24;
        local26.alternativa3d::offset = local13 * local22 + local14 * local23 + local15 * local24;
        local27.alternativa3d::cameraX = -local22;
        local27.alternativa3d::cameraY = -local23;
        local27.alternativa3d::cameraZ = -local24;
        local27.alternativa3d::offset = -local3.alternativa3d::cameraX * local22 - local3.alternativa3d::cameraY * local23 - local3.alternativa3d::cameraZ * local24;
        local28 = local27.alternativa3d::next;
        local29 = local28.alternativa3d::next;
        local13 = local6.alternativa3d::cameraX;
        local14 = local6.alternativa3d::cameraY;
        local15 = local6.alternativa3d::cameraZ;
        local16 = local7.alternativa3d::cameraX - local13;
        local17 = local7.alternativa3d::cameraY - local14;
        local18 = local7.alternativa3d::cameraZ - local15;
        local19 = local8.alternativa3d::cameraX - local13;
        local20 = local8.alternativa3d::cameraY - local14;
        local21 = local8.alternativa3d::cameraZ - local15;
        local22 = local21 * local17 - local20 * local18;
        local23 = local19 * local18 - local21 * local16;
        local24 = local20 * local16 - local19 * local17;
        local25 = 1 / Math.sqrt(local22 * local22 + local23 * local23 + local24 * local24);
        local22 *= local25;
        local23 *= local25;
        local24 *= local25;
        local28.alternativa3d::cameraX = local22;
        local28.alternativa3d::cameraY = local23;
        local28.alternativa3d::cameraZ = local24;
        local28.alternativa3d::offset = local13 * local22 + local14 * local23 + local15 * local24;
        local29.alternativa3d::cameraX = -local22;
        local29.alternativa3d::cameraY = -local23;
        local29.alternativa3d::cameraZ = -local24;
        local29.alternativa3d::offset = -local2.alternativa3d::cameraX * local22 - local2.alternativa3d::cameraY * local23 - local2.alternativa3d::cameraZ * local24;
        if(local11.alternativa3d::offset < -local12.alternativa3d::offset) {
          local12.alternativa3d::cameraX = -local12.alternativa3d::cameraX;
          local12.alternativa3d::cameraY = -local12.alternativa3d::cameraY;
          local12.alternativa3d::cameraZ = -local12.alternativa3d::cameraZ;
          local12.alternativa3d::offset = -local12.alternativa3d::offset;
          local11.alternativa3d::cameraX = -local11.alternativa3d::cameraX;
          local11.alternativa3d::cameraY = -local11.alternativa3d::cameraY;
          local11.alternativa3d::cameraZ = -local11.alternativa3d::cameraZ;
          local11.alternativa3d::offset = -local11.alternativa3d::offset;
        }
        if(local26.alternativa3d::offset < -local27.alternativa3d::offset) {
          local26.alternativa3d::cameraX = -local26.alternativa3d::cameraX;
          local26.alternativa3d::cameraY = -local26.alternativa3d::cameraY;
          local26.alternativa3d::cameraZ = -local26.alternativa3d::cameraZ;
          local26.alternativa3d::offset = -local26.alternativa3d::offset;
          local27.alternativa3d::cameraX = -local27.alternativa3d::cameraX;
          local27.alternativa3d::cameraY = -local27.alternativa3d::cameraY;
          local27.alternativa3d::cameraZ = -local27.alternativa3d::cameraZ;
          local27.alternativa3d::offset = -local27.alternativa3d::offset;
        }
        if(local29.alternativa3d::offset < -local28.alternativa3d::offset) {
          local29.alternativa3d::cameraX = -local29.alternativa3d::cameraX;
          local29.alternativa3d::cameraY = -local29.alternativa3d::cameraY;
          local29.alternativa3d::cameraZ = -local29.alternativa3d::cameraZ;
          local29.alternativa3d::offset = -local29.alternativa3d::offset;
          local28.alternativa3d::cameraX = -local28.alternativa3d::cameraX;
          local28.alternativa3d::cameraY = -local28.alternativa3d::cameraY;
          local28.alternativa3d::cameraZ = -local28.alternativa3d::cameraZ;
          local28.alternativa3d::offset = -local28.alternativa3d::offset;
        }
      }
      this.alternativa3d::space = 2;
    }

    private function calculateAABBStruct(param1:Face, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number) : void {
      var local16:Wrapper = null;
      var local17:Vertex = null;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local15:Face = param1;
      while(local15 != null) {
        local16 = local15.alternativa3d::wrapper;
        while(local16 != null) {
          local17 = local16.alternativa3d::vertex;
          if(local17.alternativa3d::transformId != param2) {
            local18 = local17.alternativa3d::cameraX;
            local19 = local17.alternativa3d::cameraY;
            local20 = local17.alternativa3d::cameraZ;
            local17.alternativa3d::cameraX = param3 * local18 + param4 * local19 + param5 * local20 + param6;
            local17.alternativa3d::cameraY = param7 * local18 + param8 * local19 + param9 * local20 + param10;
            local17.alternativa3d::cameraZ = param11 * local18 + param12 * local19 + param13 * local20 + param14;
            if(local17.alternativa3d::cameraX < this.alternativa3d::boundMinX) {
              this.alternativa3d::boundMinX = local17.alternativa3d::cameraX;
            }
            if(local17.alternativa3d::cameraX > this.alternativa3d::boundMaxX) {
              this.alternativa3d::boundMaxX = local17.alternativa3d::cameraX;
            }
            if(local17.alternativa3d::cameraY < this.alternativa3d::boundMinY) {
              this.alternativa3d::boundMinY = local17.alternativa3d::cameraY;
            }
            if(local17.alternativa3d::cameraY > this.alternativa3d::boundMaxY) {
              this.alternativa3d::boundMaxY = local17.alternativa3d::cameraY;
            }
            if(local17.alternativa3d::cameraZ < this.alternativa3d::boundMinZ) {
              this.alternativa3d::boundMinZ = local17.alternativa3d::cameraZ;
            }
            if(local17.alternativa3d::cameraZ > this.alternativa3d::boundMaxZ) {
              this.alternativa3d::boundMaxZ = local17.alternativa3d::cameraZ;
            }
            local17.alternativa3d::transformId = param2;
          }
          local16 = local16.alternativa3d::next;
        }
        local15 = local15.alternativa3d::processNext;
      }
      if(param1.alternativa3d::processNegative != null) {
        this.calculateAABBStruct(param1.alternativa3d::processNegative,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
      if(param1.alternativa3d::processPositive != null) {
        this.calculateAABBStruct(param1.alternativa3d::processPositive,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
    }

    private function calculateOOBBStruct(param1:Face, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number) : void {
      var local16:Wrapper = null;
      var local17:Vertex = null;
      var local15:Face = param1;
      while(local15 != null) {
        local16 = local15.alternativa3d::wrapper;
        while(local16 != null) {
          local17 = local16.alternativa3d::vertex;
          if(local17.alternativa3d::transformId != param2) {
            if(local17.x < this.alternativa3d::boundMinX) {
              this.alternativa3d::boundMinX = local17.x;
            }
            if(local17.x > this.alternativa3d::boundMaxX) {
              this.alternativa3d::boundMaxX = local17.x;
            }
            if(local17.y < this.alternativa3d::boundMinY) {
              this.alternativa3d::boundMinY = local17.y;
            }
            if(local17.y > this.alternativa3d::boundMaxY) {
              this.alternativa3d::boundMaxY = local17.y;
            }
            if(local17.z < this.alternativa3d::boundMinZ) {
              this.alternativa3d::boundMinZ = local17.z;
            }
            if(local17.z > this.alternativa3d::boundMaxZ) {
              this.alternativa3d::boundMaxZ = local17.z;
            }
            local17.alternativa3d::transformId = param2;
          }
          local16 = local16.alternativa3d::next;
        }
        local15 = local15.alternativa3d::processNext;
      }
      if(param1.alternativa3d::processNegative != null) {
        this.calculateOOBBStruct(param1.alternativa3d::processNegative,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
      if(param1.alternativa3d::processPositive != null) {
        this.calculateOOBBStruct(param1.alternativa3d::processPositive,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
    }

    private function updateAABBStruct(param1:Face, param2:int) : void {
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local3:Face = param1;
      while(local3 != null) {
        local4 = local3.alternativa3d::wrapper;
        while(local4 != null) {
          local5 = local4.alternativa3d::vertex;
          if(local5.alternativa3d::transformId != param2) {
            if(local5.alternativa3d::cameraX < this.alternativa3d::boundMinX) {
              this.alternativa3d::boundMinX = local5.alternativa3d::cameraX;
            }
            if(local5.alternativa3d::cameraX > this.alternativa3d::boundMaxX) {
              this.alternativa3d::boundMaxX = local5.alternativa3d::cameraX;
            }
            if(local5.alternativa3d::cameraY < this.alternativa3d::boundMinY) {
              this.alternativa3d::boundMinY = local5.alternativa3d::cameraY;
            }
            if(local5.alternativa3d::cameraY > this.alternativa3d::boundMaxY) {
              this.alternativa3d::boundMaxY = local5.alternativa3d::cameraY;
            }
            if(local5.alternativa3d::cameraZ < this.alternativa3d::boundMinZ) {
              this.alternativa3d::boundMinZ = local5.alternativa3d::cameraZ;
            }
            if(local5.alternativa3d::cameraZ > this.alternativa3d::boundMaxZ) {
              this.alternativa3d::boundMaxZ = local5.alternativa3d::cameraZ;
            }
            local5.alternativa3d::transformId = param2;
          }
          local4 = local4.alternativa3d::next;
        }
        local3 = local3.alternativa3d::processNext;
      }
      if(param1.alternativa3d::processNegative != null) {
        this.updateAABBStruct(param1.alternativa3d::processNegative,param2);
      }
      if(param1.alternativa3d::processPositive != null) {
        this.updateAABBStruct(param1.alternativa3d::processPositive,param2);
      }
    }

    alternativa3d function split(param1:Camera3D, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      var local8:VG = null;
      var local7:Face = this.alternativa3d::faceStruct.alternativa3d::create();
      this.splitFaceStruct(param1,this.alternativa3d::faceStruct,local7,param2,param3,param4,param5,param5 - param6,param5 + param6);
      if(local7.alternativa3d::processNegative != null) {
        if(collector != null) {
          local8 = collector;
          collector = collector.alternativa3d::next;
          local8.alternativa3d::next = null;
        } else {
          local8 = new VG();
        }
        this.alternativa3d::next = local8;
        local8.alternativa3d::faceStruct = local7.alternativa3d::processNegative;
        local7.alternativa3d::processNegative = null;
        local8.alternativa3d::object = this.alternativa3d::object;
        local8.alternativa3d::alpha = this.alternativa3d::alpha;
        local8.alternativa3d::blendMode = this.alternativa3d::blendMode;
        local8.alternativa3d::colorTransform = this.alternativa3d::colorTransform;
        local8.alternativa3d::filters = this.alternativa3d::filters;
        local8.alternativa3d::sorting = this.alternativa3d::sorting;
        local8.alternativa3d::debug = this.alternativa3d::debug;
        local8.alternativa3d::space = this.alternativa3d::space;
        local8.alternativa3d::viewAligned = this.alternativa3d::viewAligned;
        if(this.alternativa3d::viewAligned) {
          local8.alternativa3d::tma = this.alternativa3d::tma;
          local8.alternativa3d::tmb = this.alternativa3d::tmb;
          local8.alternativa3d::tmc = this.alternativa3d::tmc;
          local8.alternativa3d::tmd = this.alternativa3d::tmd;
          local8.alternativa3d::tmtx = this.alternativa3d::tmtx;
          local8.alternativa3d::tmty = this.alternativa3d::tmty;
        }
        local8.alternativa3d::boundMinX = 1e+22;
        local8.alternativa3d::boundMinY = 1e+22;
        local8.alternativa3d::boundMinZ = 1e+22;
        local8.alternativa3d::boundMaxX = -1e+22;
        local8.alternativa3d::boundMaxY = -1e+22;
        local8.alternativa3d::boundMaxZ = -1e+22;
        local8.updateAABBStruct(local8.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId);
      } else {
        this.alternativa3d::next = null;
      }
      if(local7.alternativa3d::processPositive != null) {
        this.alternativa3d::faceStruct = local7.alternativa3d::processPositive;
        local7.alternativa3d::processPositive = null;
        this.alternativa3d::boundMinX = 1e+22;
        this.alternativa3d::boundMinY = 1e+22;
        this.alternativa3d::boundMinZ = 1e+22;
        this.alternativa3d::boundMaxX = -1e+22;
        this.alternativa3d::boundMaxY = -1e+22;
        this.alternativa3d::boundMaxZ = -1e+22;
        this.updateAABBStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId);
      } else {
        this.alternativa3d::faceStruct = null;
      }
      local7.alternativa3d::next = Face.alternativa3d::collector;
      Face.alternativa3d::collector = local7;
    }

    alternativa3d function crop(param1:Camera3D, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      this.alternativa3d::faceStruct = this.cropFaceStruct(param1,this.alternativa3d::faceStruct,param2,param3,param4,param5,param5 - param6,param5 + param6);
      if(this.alternativa3d::faceStruct != null) {
        this.alternativa3d::boundMinX = 1e+22;
        this.alternativa3d::boundMinY = 1e+22;
        this.alternativa3d::boundMinZ = 1e+22;
        this.alternativa3d::boundMaxX = -1e+22;
        this.alternativa3d::boundMaxY = -1e+22;
        this.alternativa3d::boundMaxZ = -1e+22;
        this.updateAABBStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId);
      }
    }

    private function splitFaceStruct(param1:Camera3D, param2:Face, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : void {
      var local10:Face = null;
      var local11:Face = null;
      var local12:Wrapper = null;
      var local13:Vertex = null;
      var local14:Vertex = null;
      var local15:Face = null;
      var local16:Face = null;
      var local17:Face = null;
      var local18:Face = null;
      var local19:Face = null;
      var local20:Face = null;
      var local21:Face = null;
      var local22:Face = null;
      var local23:Face = null;
      var local24:Face = null;
      var local25:Wrapper = null;
      var local26:Wrapper = null;
      var local27:Wrapper = null;
      var local28:Boolean = false;
      var local29:Vertex = null;
      var local30:Vertex = null;
      var local31:Vertex = null;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Boolean = false;
      var local36:Boolean = false;
      var local37:Boolean = false;
      var local38:Number = NaN;
      var local39:Number = NaN;
      if(param2.alternativa3d::processNegative != null) {
        this.splitFaceStruct(param1,param2.alternativa3d::processNegative,param3,param4,param5,param6,param7,param8,param9);
        param2.alternativa3d::processNegative = null;
        local15 = param3.alternativa3d::processNegative;
        local16 = param3.alternativa3d::processPositive;
      }
      if(param2.alternativa3d::processPositive != null) {
        this.splitFaceStruct(param1,param2.alternativa3d::processPositive,param3,param4,param5,param6,param7,param8,param9);
        param2.alternativa3d::processPositive = null;
        local17 = param3.alternativa3d::processNegative;
        local18 = param3.alternativa3d::processPositive;
      }
      if(param2.alternativa3d::wrapper != null) {
        local10 = param2;
        while(local10 != null) {
          local11 = local10.alternativa3d::processNext;
          local12 = local10.alternativa3d::wrapper;
          local29 = local12.alternativa3d::vertex;
          local12 = local12.alternativa3d::next;
          local30 = local12.alternativa3d::vertex;
          local12 = local12.alternativa3d::next;
          local31 = local12.alternativa3d::vertex;
          local12 = local12.alternativa3d::next;
          local32 = local29.alternativa3d::cameraX * param4 + local29.alternativa3d::cameraY * param5 + local29.alternativa3d::cameraZ * param6;
          local33 = local30.alternativa3d::cameraX * param4 + local30.alternativa3d::cameraY * param5 + local30.alternativa3d::cameraZ * param6;
          local34 = local31.alternativa3d::cameraX * param4 + local31.alternativa3d::cameraY * param5 + local31.alternativa3d::cameraZ * param6;
          local35 = local32 < param8 || local33 < param8 || local34 < param8;
          local36 = local32 > param9 || local33 > param9 || local34 > param9;
          local37 = local32 < param8 && local33 < param8 && local34 < param8;
          while(local12 != null) {
            local13 = local12.alternativa3d::vertex;
            local38 = local13.alternativa3d::cameraX * param4 + local13.alternativa3d::cameraY * param5 + local13.alternativa3d::cameraZ * param6;
            if(local38 < param8) {
              local35 = true;
            } else {
              local37 = false;
              if(local38 > param9) {
                local36 = true;
              }
            }
            local13.alternativa3d::offset = local38;
            local12 = local12.alternativa3d::next;
          }
          if(!local35) {
            if(local21 != null) {
              local22.alternativa3d::processNext = local10;
            } else {
              local21 = local10;
            }
            local22 = local10;
          } else if(!local36) {
            if(local37) {
              if(local19 != null) {
                local20.alternativa3d::processNext = local10;
              } else {
                local19 = local10;
              }
              local20 = local10;
            } else {
              local29.alternativa3d::offset = local32;
              local30.alternativa3d::offset = local33;
              local31.alternativa3d::offset = local34;
              local23 = local10.alternativa3d::create();
              local23.material = local10.material;
              param1.alternativa3d::lastFace.alternativa3d::next = local23;
              param1.alternativa3d::lastFace = local23;
              local25 = null;
              local28 = local10.material != null && Boolean(local10.material.alternativa3d::useVerticesNormals);
              local12 = local10.alternativa3d::wrapper;
              while(local12 != null) {
                local30 = local12.alternativa3d::vertex;
                if(local30.alternativa3d::offset >= param8) {
                  local14 = local30.alternativa3d::create();
                  param1.alternativa3d::lastVertex.alternativa3d::next = local14;
                  param1.alternativa3d::lastVertex = local14;
                  local14.x = local30.x;
                  local14.y = local30.y;
                  local14.z = local30.z;
                  local14.u = local30.u;
                  local14.v = local30.v;
                  local14.alternativa3d::cameraX = local30.alternativa3d::cameraX;
                  local14.alternativa3d::cameraY = local30.alternativa3d::cameraY;
                  local14.alternativa3d::cameraZ = local30.alternativa3d::cameraZ;
                  if(local28) {
                    local14.normalX = local30.normalX;
                    local14.normalY = local30.normalY;
                    local14.normalZ = local30.normalZ;
                  }
                  local30 = local14;
                }
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local30;
                if(local25 != null) {
                  local25.alternativa3d::next = local27;
                } else {
                  local23.alternativa3d::wrapper = local27;
                }
                local25 = local27;
                local12 = local12.alternativa3d::next;
              }
              if(local19 != null) {
                local20.alternativa3d::processNext = local23;
              } else {
                local19 = local23;
              }
              local20 = local23;
              local10.alternativa3d::processNext = null;
            }
          } else {
            local29.alternativa3d::offset = local32;
            local30.alternativa3d::offset = local33;
            local31.alternativa3d::offset = local34;
            local23 = local10.alternativa3d::create();
            local23.material = local10.material;
            param1.alternativa3d::lastFace.alternativa3d::next = local23;
            param1.alternativa3d::lastFace = local23;
            local24 = local10.alternativa3d::create();
            local24.material = local10.material;
            param1.alternativa3d::lastFace.alternativa3d::next = local24;
            param1.alternativa3d::lastFace = local24;
            local25 = null;
            local26 = null;
            local12 = local10.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
            while(local12.alternativa3d::next != null) {
              local12 = local12.alternativa3d::next;
            }
            local29 = local12.alternativa3d::vertex;
            local32 = local29.alternativa3d::offset;
            local28 = local10.material != null && Boolean(local10.material.alternativa3d::useVerticesNormals);
            local12 = local10.alternativa3d::wrapper;
            while(local12 != null) {
              local30 = local12.alternativa3d::vertex;
              local33 = local30.alternativa3d::offset;
              if(local32 < param8 && local33 > param9 || local32 > param9 && local33 < param8) {
                local39 = (param7 - local32) / (local33 - local32);
                local13 = local30.alternativa3d::create();
                param1.alternativa3d::lastVertex.alternativa3d::next = local13;
                param1.alternativa3d::lastVertex = local13;
                local13.x = local29.x + (local30.x - local29.x) * local39;
                local13.y = local29.y + (local30.y - local29.y) * local39;
                local13.z = local29.z + (local30.z - local29.z) * local39;
                local13.u = local29.u + (local30.u - local29.u) * local39;
                local13.v = local29.v + (local30.v - local29.v) * local39;
                local13.alternativa3d::cameraX = local29.alternativa3d::cameraX + (local30.alternativa3d::cameraX - local29.alternativa3d::cameraX) * local39;
                local13.alternativa3d::cameraY = local29.alternativa3d::cameraY + (local30.alternativa3d::cameraY - local29.alternativa3d::cameraY) * local39;
                local13.alternativa3d::cameraZ = local29.alternativa3d::cameraZ + (local30.alternativa3d::cameraZ - local29.alternativa3d::cameraZ) * local39;
                if(local28) {
                  local13.normalX = local29.normalX + (local30.normalX - local29.normalX) * local39;
                  local13.normalY = local29.normalY + (local30.normalY - local29.normalY) * local39;
                  local13.normalZ = local29.normalZ + (local30.normalZ - local29.normalZ) * local39;
                }
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local13;
                if(local25 != null) {
                  local25.alternativa3d::next = local27;
                } else {
                  local23.alternativa3d::wrapper = local27;
                }
                local25 = local27;
                local14 = local30.alternativa3d::create();
                param1.alternativa3d::lastVertex.alternativa3d::next = local14;
                param1.alternativa3d::lastVertex = local14;
                local14.x = local13.x;
                local14.y = local13.y;
                local14.z = local13.z;
                local14.u = local13.u;
                local14.v = local13.v;
                local14.alternativa3d::cameraX = local13.alternativa3d::cameraX;
                local14.alternativa3d::cameraY = local13.alternativa3d::cameraY;
                local14.alternativa3d::cameraZ = local13.alternativa3d::cameraZ;
                if(local28) {
                  local14.normalX = local13.normalX;
                  local14.normalY = local13.normalY;
                  local14.normalZ = local13.normalZ;
                }
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local14;
                if(local26 != null) {
                  local26.alternativa3d::next = local27;
                } else {
                  local24.alternativa3d::wrapper = local27;
                }
                local26 = local27;
              }
              if(local30.alternativa3d::offset < param8) {
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local30;
                if(local25 != null) {
                  local25.alternativa3d::next = local27;
                } else {
                  local23.alternativa3d::wrapper = local27;
                }
                local25 = local27;
              } else if(local30.alternativa3d::offset > param9) {
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local30;
                if(local26 != null) {
                  local26.alternativa3d::next = local27;
                } else {
                  local24.alternativa3d::wrapper = local27;
                }
                local26 = local27;
              } else {
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local30;
                if(local26 != null) {
                  local26.alternativa3d::next = local27;
                } else {
                  local24.alternativa3d::wrapper = local27;
                }
                local26 = local27;
                local14 = local30.alternativa3d::create();
                param1.alternativa3d::lastVertex.alternativa3d::next = local14;
                param1.alternativa3d::lastVertex = local14;
                local14.x = local30.x;
                local14.y = local30.y;
                local14.z = local30.z;
                local14.u = local30.u;
                local14.v = local30.v;
                local14.alternativa3d::cameraX = local30.alternativa3d::cameraX;
                local14.alternativa3d::cameraY = local30.alternativa3d::cameraY;
                local14.alternativa3d::cameraZ = local30.alternativa3d::cameraZ;
                if(local28) {
                  local14.normalX = local30.normalX;
                  local14.normalY = local30.normalY;
                  local14.normalZ = local30.normalZ;
                }
                local27 = local12.alternativa3d::create();
                local27.alternativa3d::vertex = local14;
                if(local25 != null) {
                  local25.alternativa3d::next = local27;
                } else {
                  local23.alternativa3d::wrapper = local27;
                }
                local25 = local27;
              }
              local29 = local30;
              local32 = local33;
              local12 = local12.alternativa3d::next;
            }
            if(local19 != null) {
              local20.alternativa3d::processNext = local23;
            } else {
              local19 = local23;
            }
            local20 = local23;
            if(local21 != null) {
              local22.alternativa3d::processNext = local24;
            } else {
              local21 = local24;
            }
            local22 = local24;
            local10.alternativa3d::processNext = null;
          }
          local10 = local11;
        }
      }
      if(local19 != null || local15 != null && local17 != null) {
        if(local19 == null) {
          local19 = param2.alternativa3d::create();
          param1.alternativa3d::lastFace.alternativa3d::next = local19;
          param1.alternativa3d::lastFace = local19;
        } else {
          local20.alternativa3d::processNext = null;
        }
        if(this.alternativa3d::sorting == 3) {
          local19.alternativa3d::normalX = param2.alternativa3d::normalX;
          local19.alternativa3d::normalY = param2.alternativa3d::normalY;
          local19.alternativa3d::normalZ = param2.alternativa3d::normalZ;
          local19.alternativa3d::offset = param2.alternativa3d::offset;
        }
        local19.alternativa3d::processNegative = local15;
        local19.alternativa3d::processPositive = local17;
        param3.alternativa3d::processNegative = local19;
      } else {
        param3.alternativa3d::processNegative = local15 != null ? local15 : local17;
      }
      if(local21 != null || local16 != null && local18 != null) {
        if(local21 == null) {
          local21 = param2.alternativa3d::create();
          param1.alternativa3d::lastFace.alternativa3d::next = local21;
          param1.alternativa3d::lastFace = local21;
        } else {
          local22.alternativa3d::processNext = null;
        }
        if(this.alternativa3d::sorting == 3) {
          local21.alternativa3d::normalX = param2.alternativa3d::normalX;
          local21.alternativa3d::normalY = param2.alternativa3d::normalY;
          local21.alternativa3d::normalZ = param2.alternativa3d::normalZ;
          local21.alternativa3d::offset = param2.alternativa3d::offset;
        }
        local21.alternativa3d::processNegative = local16;
        local21.alternativa3d::processPositive = local18;
        param3.alternativa3d::processPositive = local21;
      } else {
        param3.alternativa3d::processPositive = local16 != null ? local16 : local18;
      }
    }

    private function cropFaceStruct(param1:Camera3D, param2:Face, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Face {
      var local9:Face = null;
      var local10:Face = null;
      var local11:Wrapper = null;
      var local12:Vertex = null;
      var local13:Face = null;
      var local14:Face = null;
      var local15:Face = null;
      var local16:Face = null;
      var local17:Vertex = null;
      var local18:Vertex = null;
      var local19:Vertex = null;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Boolean = false;
      var local24:Boolean = false;
      var local25:Number = NaN;
      var local26:Face = null;
      var local27:Wrapper = null;
      var local28:Wrapper = null;
      var local29:Boolean = false;
      var local30:Number = NaN;
      if(param2.alternativa3d::processNegative != null) {
        local13 = this.cropFaceStruct(param1,param2.alternativa3d::processNegative,param3,param4,param5,param6,param7,param8);
        param2.alternativa3d::processNegative = null;
      }
      if(param2.alternativa3d::processPositive != null) {
        local14 = this.cropFaceStruct(param1,param2.alternativa3d::processPositive,param3,param4,param5,param6,param7,param8);
        param2.alternativa3d::processPositive = null;
      }
      if(param2.alternativa3d::wrapper != null) {
        local9 = param2;
        while(local9 != null) {
          local10 = local9.alternativa3d::processNext;
          local11 = local9.alternativa3d::wrapper;
          local17 = local11.alternativa3d::vertex;
          local11 = local11.alternativa3d::next;
          local18 = local11.alternativa3d::vertex;
          local11 = local11.alternativa3d::next;
          local19 = local11.alternativa3d::vertex;
          local11 = local11.alternativa3d::next;
          local20 = local17.alternativa3d::cameraX * param3 + local17.alternativa3d::cameraY * param4 + local17.alternativa3d::cameraZ * param5;
          local21 = local18.alternativa3d::cameraX * param3 + local18.alternativa3d::cameraY * param4 + local18.alternativa3d::cameraZ * param5;
          local22 = local19.alternativa3d::cameraX * param3 + local19.alternativa3d::cameraY * param4 + local19.alternativa3d::cameraZ * param5;
          local23 = local20 < param7 || local21 < param7 || local22 < param7;
          local24 = local20 > param8 || local21 > param8 || local22 > param8;
          while(local11 != null) {
            local12 = local11.alternativa3d::vertex;
            local25 = local12.alternativa3d::cameraX * param3 + local12.alternativa3d::cameraY * param4 + local12.alternativa3d::cameraZ * param5;
            if(local25 < param7) {
              local23 = true;
            } else if(local25 > param8) {
              local24 = true;
            }
            local12.alternativa3d::offset = local25;
            local11 = local11.alternativa3d::next;
          }
          if(!local24) {
            local9.alternativa3d::processNext = null;
          } else if(!local23) {
            if(local15 != null) {
              local16.alternativa3d::processNext = local9;
            } else {
              local15 = local9;
            }
            local16 = local9;
          } else {
            local17.alternativa3d::offset = local20;
            local18.alternativa3d::offset = local21;
            local19.alternativa3d::offset = local22;
            local26 = local9.alternativa3d::create();
            local26.material = local9.material;
            param1.alternativa3d::lastFace.alternativa3d::next = local26;
            param1.alternativa3d::lastFace = local26;
            local27 = null;
            local11 = local9.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
            while(local11.alternativa3d::next != null) {
              local11 = local11.alternativa3d::next;
            }
            local17 = local11.alternativa3d::vertex;
            local20 = local17.alternativa3d::offset;
            local29 = local9.material != null && Boolean(local9.material.alternativa3d::useVerticesNormals);
            local11 = local9.alternativa3d::wrapper;
            while(local11 != null) {
              local18 = local11.alternativa3d::vertex;
              local21 = local18.alternativa3d::offset;
              if(local20 < param7 && local21 > param8 || local20 > param8 && local21 < param7) {
                local30 = (param6 - local20) / (local21 - local20);
                local12 = local18.alternativa3d::create();
                param1.alternativa3d::lastVertex.alternativa3d::next = local12;
                param1.alternativa3d::lastVertex = local12;
                local12.x = local17.x + (local18.x - local17.x) * local30;
                local12.y = local17.y + (local18.y - local17.y) * local30;
                local12.z = local17.z + (local18.z - local17.z) * local30;
                local12.u = local17.u + (local18.u - local17.u) * local30;
                local12.v = local17.v + (local18.v - local17.v) * local30;
                local12.alternativa3d::cameraX = local17.alternativa3d::cameraX + (local18.alternativa3d::cameraX - local17.alternativa3d::cameraX) * local30;
                local12.alternativa3d::cameraY = local17.alternativa3d::cameraY + (local18.alternativa3d::cameraY - local17.alternativa3d::cameraY) * local30;
                local12.alternativa3d::cameraZ = local17.alternativa3d::cameraZ + (local18.alternativa3d::cameraZ - local17.alternativa3d::cameraZ) * local30;
                if(local29) {
                  local12.normalX = local17.normalX + (local18.normalX - local17.normalX) * local30;
                  local12.normalY = local17.normalY + (local18.normalY - local17.normalY) * local30;
                  local12.normalZ = local17.normalZ + (local18.normalZ - local17.normalZ) * local30;
                }
                local28 = local11.alternativa3d::create();
                local28.alternativa3d::vertex = local12;
                if(local27 != null) {
                  local27.alternativa3d::next = local28;
                } else {
                  local26.alternativa3d::wrapper = local28;
                }
                local27 = local28;
              }
              if(local21 >= param7) {
                local28 = local11.alternativa3d::create();
                local28.alternativa3d::vertex = local18;
                if(local27 != null) {
                  local27.alternativa3d::next = local28;
                } else {
                  local26.alternativa3d::wrapper = local28;
                }
                local27 = local28;
              }
              local17 = local18;
              local20 = local21;
              local11 = local11.alternativa3d::next;
            }
            if(local15 != null) {
              local16.alternativa3d::processNext = local26;
            } else {
              local15 = local26;
            }
            local16 = local26;
            local9.alternativa3d::processNext = null;
          }
          local9 = local10;
        }
      }
      if(local15 != null || local13 != null && local14 != null) {
        if(local15 == null) {
          local15 = param2.alternativa3d::create();
          param1.alternativa3d::lastFace.alternativa3d::next = local15;
          param1.alternativa3d::lastFace = local15;
        } else {
          local16.alternativa3d::processNext = null;
        }
        if(this.alternativa3d::sorting == 3) {
          local15.alternativa3d::normalX = param2.alternativa3d::normalX;
          local15.alternativa3d::normalY = param2.alternativa3d::normalY;
          local15.alternativa3d::normalZ = param2.alternativa3d::normalZ;
          local15.alternativa3d::offset = param2.alternativa3d::offset;
        }
        local15.alternativa3d::processNegative = local13;
        local15.alternativa3d::processPositive = local14;
        return local15;
      }
      return local13 != null ? local13 : local14;
    }

    alternativa3d function transformStruct(param1:Face, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number) : void {
      var local16:Wrapper = null;
      var local17:Vertex = null;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local15:Face = param1;
      while(local15 != null) {
        local16 = local15.alternativa3d::wrapper;
        while(local16 != null) {
          local17 = local16.alternativa3d::vertex;
          if(local17.alternativa3d::transformId != param2) {
            local18 = local17.alternativa3d::cameraX;
            local19 = local17.alternativa3d::cameraY;
            local20 = local17.alternativa3d::cameraZ;
            local17.alternativa3d::cameraX = param3 * local18 + param4 * local19 + param5 * local20 + param6;
            local17.alternativa3d::cameraY = param7 * local18 + param8 * local19 + param9 * local20 + param10;
            local17.alternativa3d::cameraZ = param11 * local18 + param12 * local19 + param13 * local20 + param14;
            local17.alternativa3d::transformId = param2;
          }
          local16 = local16.alternativa3d::next;
        }
        local15 = local15.alternativa3d::processNext;
      }
      if(param1.alternativa3d::processNegative != null) {
        this.alternativa3d::transformStruct(param1.alternativa3d::processNegative,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
      if(param1.alternativa3d::processPositive != null) {
        this.alternativa3d::transformStruct(param1.alternativa3d::processPositive,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
      }
    }

    alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Number, param4:Object3D) : void {
      var local5:Canvas = null;
      var local6:Face = null;
      var local7:Face = null;
      var local8:Face = null;
      if(this.alternativa3d::space == 1) {
        this.alternativa3d::transformStruct(this.alternativa3d::faceStruct,++this.alternativa3d::object.alternativa3d::transformId,param4.alternativa3d::ma,param4.alternativa3d::mb,param4.alternativa3d::mc,param4.alternativa3d::md,param4.alternativa3d::me,param4.alternativa3d::mf,param4.alternativa3d::mg,param4.alternativa3d::mh,param4.alternativa3d::mi,param4.alternativa3d::mj,param4.alternativa3d::mk,param4.alternativa3d::ml);
      }
      if(this.alternativa3d::viewAligned) {
        local6 = this.alternativa3d::faceStruct;
        if(this.alternativa3d::debug > 0) {
          local5 = param2.alternativa3d::getChildCanvas(true,false);
          if(Boolean(this.alternativa3d::debug & Debug.EDGES)) {
            Debug.alternativa3d::drawEdges(param1,local5,local6,this.alternativa3d::space != 2 ? 16777215 : 16750848);
          }
          if(Boolean(this.alternativa3d::debug & Debug.BOUNDS)) {
            if(this.alternativa3d::space == 1) {
              Debug.alternativa3d::drawBounds(param1,local5,param4,this.alternativa3d::boundMinX,this.alternativa3d::boundMinY,this.alternativa3d::boundMinZ,this.alternativa3d::boundMaxX,this.alternativa3d::boundMaxY,this.alternativa3d::boundMaxZ,10092288);
            }
          }
        }
        local5 = param2.alternativa3d::getChildCanvas(true,false,this.alternativa3d::object,this.alternativa3d::alpha,this.alternativa3d::blendMode,this.alternativa3d::colorTransform,this.alternativa3d::filters);
        local6.material.alternativa3d::drawViewAligned(param1,local5,local6,this.alternativa3d::object.alternativa3d::ml,this.alternativa3d::tma,this.alternativa3d::tmb,this.alternativa3d::tmc,this.alternativa3d::tmd,this.alternativa3d::tmtx,this.alternativa3d::tmty);
      } else {
        switch(this.alternativa3d::sorting) {
          case 0:
            local6 = this.alternativa3d::faceStruct;
            break;
          case 1:
            local6 = this.alternativa3d::faceStruct.alternativa3d::processNext != null ? param1.alternativa3d::sortByAverageZ(this.alternativa3d::faceStruct) : this.alternativa3d::faceStruct;
            break;
          case 2:
            local6 = this.alternativa3d::faceStruct.alternativa3d::processNext != null ? param1.alternativa3d::sortByDynamicBSP(this.alternativa3d::faceStruct,param3) : this.alternativa3d::faceStruct;
            break;
          case 3:
            local6 = this.collectNode(this.alternativa3d::faceStruct);
        }
        if(this.alternativa3d::debug > 0) {
          local5 = param2.alternativa3d::getChildCanvas(true,false);
          if(Boolean(this.alternativa3d::debug & Debug.EDGES)) {
            Debug.alternativa3d::drawEdges(param1,local5,local6,16777215);
          }
          if(Boolean(this.alternativa3d::debug & Debug.BOUNDS)) {
            if(this.alternativa3d::space == 1) {
              Debug.alternativa3d::drawBounds(param1,local5,param4,this.alternativa3d::boundMinX,this.alternativa3d::boundMinY,this.alternativa3d::boundMinZ,this.alternativa3d::boundMaxX,this.alternativa3d::boundMaxY,this.alternativa3d::boundMaxZ,10092288);
            } else if(this.alternativa3d::space == 2) {
              Debug.alternativa3d::drawBounds(param1,local5,this.alternativa3d::object,this.alternativa3d::boundMinX,this.alternativa3d::boundMinY,this.alternativa3d::boundMinZ,this.alternativa3d::boundMaxX,this.alternativa3d::boundMaxY,this.alternativa3d::boundMaxZ,16750848);
            }
          }
        }
        local5 = param2.alternativa3d::getChildCanvas(true,false,this.alternativa3d::object,this.alternativa3d::alpha,this.alternativa3d::blendMode,this.alternativa3d::colorTransform,this.alternativa3d::filters);
        local7 = local6;
        while(local7 != null) {
          local8 = local7.alternativa3d::processNext;
          if(local8 == null || local8.material != local6.material) {
            local7.alternativa3d::processNext = null;
            if(local6.material != null) {
              local6.material.alternativa3d::draw(param1,local5,local6,this.alternativa3d::object.alternativa3d::ml);
            } else {
              while(local6 != null) {
                local7 = local6.alternativa3d::processNext;
                local6.alternativa3d::processNext = null;
                local6 = local7;
              }
            }
            local6 = local8;
          }
          local7 = local8;
        }
      }
      this.alternativa3d::faceStruct = null;
    }

    private function collectNode(param1:Face, param2:Face = null) : Face {
      var local3:Face = null;
      var local4:Face = null;
      var local5:Face = null;
      if(param1.alternativa3d::offset < 0) {
        local4 = param1.alternativa3d::processNegative;
        local5 = param1.alternativa3d::processPositive;
      } else {
        local4 = param1.alternativa3d::processPositive;
        local5 = param1.alternativa3d::processNegative;
      }
      param1.alternativa3d::processNegative = null;
      param1.alternativa3d::processPositive = null;
      if(local5 != null) {
        param2 = this.collectNode(local5,param2);
      }
      if(param1.alternativa3d::wrapper != null) {
        local3 = param1;
        while(local3.alternativa3d::processNext != null) {
          local3 = local3.alternativa3d::processNext;
        }
        local3.alternativa3d::processNext = param2;
        param2 = param1;
      }
      if(local4 != null) {
        param2 = this.collectNode(local4,param2);
      }
      return param2;
    }
  }
}
