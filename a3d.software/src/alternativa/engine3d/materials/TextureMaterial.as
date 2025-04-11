package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import flash.display.BitmapData;
  import flash.filters.ConvolutionFilter;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class TextureMaterial extends Material {
    private static const filter:ConvolutionFilter = new ConvolutionFilter(2,2,[1,1,1,1],4,0,false,true);
    private static const matrix:Matrix = new Matrix(0.5,0,0,0.5);
    private static const rect:Rectangle = new Rectangle();
    private static const point:Point = new Point();

    alternativa3d static var drawVertices:Vector.<Number> = new Vector.<Number>();
    alternativa3d static var drawUVTs:Vector.<Number> = new Vector.<Number>();
    alternativa3d static var drawIndices:Vector.<int> = new Vector.<int>();
    alternativa3d static var drawMatrix:Matrix = new Matrix();

    public var diffuseMapURL:String;
    public var opacityMapURL:String;
    public var repeat:Boolean = false;
    public var smooth:Boolean = true;
    public var resolution:Number = 1;
    public var threshold:Number = 0.01;
    public var correctUV:Boolean = false;

    alternativa3d var _texture:BitmapData;
    alternativa3d var _textureATF:ByteArray;
    alternativa3d var _textureATFAlpha:ByteArray;
    alternativa3d var _mipMapping:int = 0;
    alternativa3d var _hardwareMipMaps:Boolean = false;
    alternativa3d var mipMap:Vector.<BitmapData>;
    alternativa3d var numMaps:int = 0;

    public function TextureMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1) {
      super();
      this.alternativa3d::_texture = param1;
      this.repeat = param2;
      this.smooth = param3;
      this.alternativa3d::_mipMapping = 0;
      if(this.alternativa3d::_texture != null && this.alternativa3d::_mipMapping > 0) {
        this.alternativa3d::calculateMipMaps();
      }
      this.resolution = param5;
    }

    public function get texture() : BitmapData {
      return this.alternativa3d::_texture;
    }

    public function set texture(param1:BitmapData) : void {
      if(param1 != this.alternativa3d::_texture) {
        this.alternativa3d::_texture = param1;
        this.alternativa3d::disposeMipMaps();
        if(param1 != null && this.alternativa3d::_mipMapping > 0) {
          this.alternativa3d::calculateMipMaps();
        }
      }
    }

    public function get textureATF() : ByteArray {
      return this.alternativa3d::_textureATF;
    }

    public function set textureATF(param1:ByteArray) : void {
      if(param1 != this.alternativa3d::_textureATF) {
        this.alternativa3d::_textureATF = param1;
      }
    }

    public function get textureATFAlpha() : ByteArray {
      return this.alternativa3d::_textureATFAlpha;
    }

    public function set textureATFAlpha(param1:ByteArray) : void {
      if(param1 != this.alternativa3d::_textureATFAlpha) {
        this.alternativa3d::_textureATFAlpha = param1;
      }
    }

    public function get mipMapping() : int {
      return this.alternativa3d::_mipMapping;
    }

    public function set mipMapping(param1:int) : void {
    }

    public function get hardwareMipMaps() : Boolean {
      return this.alternativa3d::_hardwareMipMaps;
    }

    public function set hardwareMipMaps(param1:Boolean) : void {
      if(param1 != this.alternativa3d::_hardwareMipMaps) {
        this.alternativa3d::_hardwareMipMaps = param1;
      }
    }

    override public function clone() : Material {
      var local1:TextureMaterial = new TextureMaterial(this.alternativa3d::_texture,this.repeat,this.smooth,this.alternativa3d::_mipMapping,this.resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:TextureMaterial = param1 as TextureMaterial;
      this.diffuseMapURL = local2.diffuseMapURL;
      this.opacityMapURL = local2.opacityMapURL;
      this.threshold = local2.threshold;
      this.correctUV = local2.correctUV;
      this.alternativa3d::_textureATF = local2.alternativa3d::_textureATF;
      this.alternativa3d::_textureATFAlpha = local2.alternativa3d::_textureATFAlpha;
    }

    alternativa3d function disposeMipMaps() : void {
      var local1:int = 1;
      while(local1 < this.alternativa3d::numMaps) {
        (this.alternativa3d::mipMap[local1] as BitmapData).dispose();
        local1++;
      }
      this.alternativa3d::mipMap = null;
      this.alternativa3d::numMaps = 0;
    }

    alternativa3d function calculateMipMaps() : void {
      var local1:BitmapData = null;
      var local4:int = 0;
      var local5:int = 0;
      var local6:BitmapData = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      this.alternativa3d::mipMap = new Vector.<BitmapData>();
      this.alternativa3d::numMaps = 0;
      this.alternativa3d::mipMap[this.alternativa3d::numMaps] = this.alternativa3d::_texture;
      ++this.alternativa3d::numMaps;
      var local2:int = Math.pow(2,Math.ceil(Math.log(this.alternativa3d::_texture.width) / Math.LN2));
      var local3:int = Math.pow(2,Math.ceil(Math.log(this.alternativa3d::_texture.height) / Math.LN2));
      if(this.alternativa3d::_texture.width == local2 && this.alternativa3d::_texture.height == local3) {
        local4 = this.alternativa3d::_texture.width;
        local5 = this.alternativa3d::_texture.height;
        while(local4 % 2 == 0 && local5 % 2 == 0) {
          local4 >>= 1;
          local5 >>= 1;
          local1 = new BitmapData(local4,local5,this.alternativa3d::_texture.transparent,0);
          matrix.a = local4 / this.alternativa3d::_texture.width;
          matrix.d = local5 / this.alternativa3d::_texture.height;
          local1.draw(this.alternativa3d::_texture,matrix,null,null,null,false);
          this.alternativa3d::mipMap[this.alternativa3d::numMaps] = local1;
          ++this.alternativa3d::numMaps;
        }
      } else {
        matrix.identity();
        filter.preserveAlpha = !this.alternativa3d::_texture.transparent;
        local1 = this.alternativa3d::_texture.width * this.alternativa3d::_texture.height > 16777215 ? this.alternativa3d::_texture.clone() : new BitmapData(this.alternativa3d::_texture.width,this.alternativa3d::_texture.height,this.alternativa3d::_texture.transparent);
        local6 = this.alternativa3d::_texture;
        local7 = rect.width = this.alternativa3d::_texture.width;
        local8 = rect.height = this.alternativa3d::_texture.height;
        while(local7 > 1 && local8 > 1 && rect.width > 1 && rect.height > 1) {
          local1.applyFilter(local6,rect,point,filter);
          rect.width = local7 >> 1;
          rect.height = local8 >> 1;
          matrix.a = rect.width / local7;
          matrix.d = rect.height / local8;
          local7 *= 0.5;
          local8 *= 0.5;
          local6 = new BitmapData(rect.width,rect.height,this.alternativa3d::_texture.transparent,0);
          local6.draw(local1,matrix,null,null,null,false);
          this.alternativa3d::mipMap[this.alternativa3d::numMaps] = local6;
          ++this.alternativa3d::numMaps;
        }
        local1.dispose();
      }
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      var local5:Face = null;
      var local6:Face = null;
      var local7:Face = null;
      var local8:Wrapper = null;
      var local9:Vertex = null;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:int = 0;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:BitmapData = null;
      var local26:int = 0;
      var local27:int = 0;
      var local28:int = 0;
      var local29:int = 0;
      var local33:int = 0;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:int = 0;
      var local38:int = 0;
      var local39:Wrapper = null;
      var local40:int = 0;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Wrapper = null;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local47:Boolean = false;
      var local48:Boolean = false;
      var local49:Number = NaN;
      var local50:Face = null;
      var local51:Wrapper = null;
      var local52:Wrapper = null;
      var local53:Wrapper = null;
      var local54:Vertex = null;
      var local55:Vertex = null;
      var local56:Vertex = null;
      var local21:Number = Number(param1.alternativa3d::viewSizeX);
      var local22:Number = Number(param1.alternativa3d::viewSizeY);
      var local23:Vector.<Number> = alternativa3d::drawVertices;
      var local24:Vector.<Number> = alternativa3d::drawUVTs;
      var local25:Vector.<int> = alternativa3d::drawIndices;
      var local30:int = int(param1.alternativa3d::numDraws);
      var local31:int = 0;
      var local32:int = 0;
      if(this.alternativa3d::_texture == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      if(this.alternativa3d::_mipMapping < 2) {
        local30++;
        local26 = 0;
        local27 = 0;
        local28 = 0;
        local29 = 0;
        local5 = param3;
        while(local5 != null) {
          local6 = local5.alternativa3d::processNext;
          local5.alternativa3d::processNext = null;
          local8 = local5.alternativa3d::wrapper;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local30) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
            local27++;
            local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
            local27++;
            local24[local28] = local9.u;
            local28++;
            local24[local28] = local9.v;
            local28++;
            local24[local28] = local13;
            local28++;
            local10 = local26;
            local9.alternativa3d::index = local26++;
            local9.alternativa3d::drawId = local30;
          } else {
            local10 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          local9 = local8.alternativa3d::vertex;
          if(local9.alternativa3d::drawId != local30) {
            local13 = 1 / local9.alternativa3d::cameraZ;
            local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
            local27++;
            local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
            local27++;
            local24[local28] = local9.u;
            local28++;
            local24[local28] = local9.v;
            local28++;
            local24[local28] = local13;
            local28++;
            local11 = local26;
            local9.alternativa3d::index = local26++;
            local9.alternativa3d::drawId = local30;
          } else {
            local11 = int(local9.alternativa3d::index);
          }
          local8 = local8.alternativa3d::next;
          while(local8 != null) {
            local9 = local8.alternativa3d::vertex;
            if(local9.alternativa3d::drawId != local30) {
              local13 = 1 / local9.alternativa3d::cameraZ;
              local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
              local27++;
              local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
              local27++;
              local24[local28] = local9.u;
              local28++;
              local24[local28] = local9.v;
              local28++;
              local24[local28] = local13;
              local28++;
              local12 = local26;
              local9.alternativa3d::index = local26++;
              local9.alternativa3d::drawId = local30;
            } else {
              local12 = int(local9.alternativa3d::index);
            }
            alternativa3d::drawIndices[local29] = local10;
            local29++;
            alternativa3d::drawIndices[local29] = local11;
            local29++;
            alternativa3d::drawIndices[local29] = local12;
            local29++;
            local11 = local12;
            local32++;
            local8 = local8.alternativa3d::next;
          }
          local31++;
          local5 = local6;
        }
        local23.length = local27;
        local24.length = local28;
        local25.length = local29;
        if(this.alternativa3d::_mipMapping == 0) {
          local20 = this.alternativa3d::_texture;
        } else {
          local14 = param1.alternativa3d::focalLength * this.resolution;
          local33 = param4 >= local14 ? int(1 + Math.log(param4 / local14) * 1.4426950408889634) : 0;
          if(local33 >= this.alternativa3d::numMaps) {
            local33 = this.alternativa3d::numMaps - 1;
          }
          local20 = this.alternativa3d::mipMap[local33];
        }
        if(this.correctUV) {
          local18 = -0.5 / (local20.width - 1);
          local19 = -0.5 / (local20.height - 1);
          local16 = 1 - local18 - local18;
          local17 = 1 - local19 - local19;
          local15 = 0;
          while(local15 < local28) {
            local24[local15] = local24[local15] * local16 + local18;
            local15++;
            local24[local15] = local24[local15] * local17 + local19;
            local15++;
            local15++;
          }
        }
        param2.alternativa3d::gfx.beginBitmapFill(local20,null,this.repeat,this.smooth);
        param2.alternativa3d::gfx.drawTriangles(local23,local25,local24,"none");
      } else {
        local35 = 1e+22;
        local36 = -1;
        local5 = param3;
        while(local5 != null) {
          local8 = local5.alternativa3d::wrapper;
          while(local8 != null) {
            local34 = Number(local8.alternativa3d::vertex.alternativa3d::cameraZ);
            if(local34 < local35) {
              local35 = local34;
            }
            if(local34 > local36) {
              local36 = local34;
            }
            local8 = local8.alternativa3d::next;
          }
          local5 = local5.alternativa3d::processNext;
        }
        local14 = param1.alternativa3d::focalLength * this.resolution;
        local37 = local35 >= local14 ? int(1 + Math.log(local35 / local14) * 1.4426950408889634) : 0;
        if(local37 >= this.alternativa3d::numMaps) {
          local37 = this.alternativa3d::numMaps - 1;
        }
        local38 = local36 >= local14 ? int(1 + Math.log(local36 / local14) * 1.4426950408889634) : 0;
        if(local38 >= this.alternativa3d::numMaps) {
          local38 = this.alternativa3d::numMaps - 1;
        }
        local34 = local14 * Math.pow(2,local38 - 1);
        local40 = local38;
        while(local40 >= local37) {
          local30++;
          local26 = 0;
          local27 = 0;
          local28 = 0;
          local29 = 0;
          local41 = local34 - this.threshold;
          local42 = local34 + this.threshold;
          local5 = param3;
          param3 = null;
          local7 = null;
          while(local5 != null) {
            local6 = local5.alternativa3d::processNext;
            local5.alternativa3d::processNext = null;
            local8 = null;
            if(local40 == local37) {
              local8 = local5.alternativa3d::wrapper;
            } else {
              local43 = local5.alternativa3d::wrapper;
              local44 = Number(local43.alternativa3d::vertex.alternativa3d::cameraZ);
              local43 = local43.alternativa3d::next;
              local45 = Number(local43.alternativa3d::vertex.alternativa3d::cameraZ);
              local43 = local43.alternativa3d::next;
              local46 = Number(local43.alternativa3d::vertex.alternativa3d::cameraZ);
              local43 = local43.alternativa3d::next;
              local47 = local44 < local41 || local45 < local41 || local46 < local41;
              local48 = local44 > local42 || local45 > local42 || local46 > local42;
              while(local43 != null) {
                local49 = Number(local43.alternativa3d::vertex.alternativa3d::cameraZ);
                if(local49 < local41) {
                  local47 = true;
                } else if(local49 > local42) {
                  local48 = true;
                }
                local43 = local43.alternativa3d::next;
              }
              if(!local47) {
                local8 = local5.alternativa3d::wrapper;
              } else if(!local48) {
                if(param3 != null) {
                  local7.alternativa3d::processNext = local5;
                } else {
                  param3 = local5;
                }
                local7 = local5;
              } else {
                local50 = local5.alternativa3d::create();
                param1.alternativa3d::lastFace.alternativa3d::next = local50;
                param1.alternativa3d::lastFace = local50;
                local51 = null;
                local52 = null;
                local43 = local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
                while(local43.alternativa3d::next != null) {
                  local43 = local43.alternativa3d::next;
                }
                local54 = local43.alternativa3d::vertex;
                local44 = Number(local54.alternativa3d::cameraZ);
                local43 = local5.alternativa3d::wrapper;
                while(local43 != null) {
                  local55 = local43.alternativa3d::vertex;
                  local45 = Number(local55.alternativa3d::cameraZ);
                  if(local44 < local41 && local45 > local42 || local44 > local42 && local45 < local41) {
                    local13 = (local34 - local44) / (local45 - local44);
                    local56 = local55.alternativa3d::create();
                    param1.alternativa3d::lastVertex.alternativa3d::next = local56;
                    param1.alternativa3d::lastVertex = local56;
                    local56.alternativa3d::cameraX = local54.alternativa3d::cameraX + (local55.alternativa3d::cameraX - local54.alternativa3d::cameraX) * local13;
                    local56.alternativa3d::cameraY = local54.alternativa3d::cameraY + (local55.alternativa3d::cameraY - local54.alternativa3d::cameraY) * local13;
                    local56.alternativa3d::cameraZ = local34;
                    local56.u = local54.u + (local55.u - local54.u) * local13;
                    local56.v = local54.v + (local55.v - local54.v) * local13;
                    local53 = local43.alternativa3d::create();
                    local53.alternativa3d::vertex = local56;
                    if(local51 != null) {
                      local51.alternativa3d::next = local53;
                    } else {
                      local50.alternativa3d::wrapper = local53;
                    }
                    local51 = local53;
                    local53 = local43.alternativa3d::create();
                    local53.alternativa3d::vertex = local56;
                    if(local52 != null) {
                      local52.alternativa3d::next = local53;
                    } else {
                      local8 = local53;
                    }
                    local52 = local53;
                  }
                  if(local45 <= local42) {
                    local53 = local43.alternativa3d::create();
                    local53.alternativa3d::vertex = local55;
                    if(local51 != null) {
                      local51.alternativa3d::next = local53;
                    } else {
                      local50.alternativa3d::wrapper = local53;
                    }
                    local51 = local53;
                  }
                  if(local45 >= local41) {
                    local53 = local43.alternativa3d::create();
                    local53.alternativa3d::vertex = local55;
                    if(local52 != null) {
                      local52.alternativa3d::next = local53;
                    } else {
                      local8 = local53;
                    }
                    local52 = local53;
                  }
                  local54 = local55;
                  local44 = local45;
                  local43 = local43.alternativa3d::next;
                }
                if(param3 != null) {
                  local7.alternativa3d::processNext = local50;
                } else {
                  param3 = local50;
                }
                local7 = local50;
                local39 = local8;
              }
            }
            if(local8 != null) {
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local30) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
                local27++;
                local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
                local27++;
                local24[local28] = local9.u;
                local28++;
                local24[local28] = local9.v;
                local28++;
                local24[local28] = local13;
                local28++;
                local10 = local26;
                local9.alternativa3d::index = local26++;
                local9.alternativa3d::drawId = local30;
              } else {
                local10 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              local9 = local8.alternativa3d::vertex;
              if(local9.alternativa3d::drawId != local30) {
                local13 = 1 / local9.alternativa3d::cameraZ;
                local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
                local27++;
                local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
                local27++;
                local24[local28] = local9.u;
                local28++;
                local24[local28] = local9.v;
                local28++;
                local24[local28] = local13;
                local28++;
                local11 = local26;
                local9.alternativa3d::index = local26++;
                local9.alternativa3d::drawId = local30;
              } else {
                local11 = int(local9.alternativa3d::index);
              }
              local8 = local8.alternativa3d::next;
              while(local8 != null) {
                local9 = local8.alternativa3d::vertex;
                if(local9.alternativa3d::drawId != local30) {
                  local13 = 1 / local9.alternativa3d::cameraZ;
                  local23[local27] = local9.alternativa3d::cameraX * local21 * local13;
                  local27++;
                  local23[local27] = local9.alternativa3d::cameraY * local22 * local13;
                  local27++;
                  local24[local28] = local9.u;
                  local28++;
                  local24[local28] = local9.v;
                  local28++;
                  local24[local28] = local13;
                  local28++;
                  local12 = local26;
                  local9.alternativa3d::index = local26++;
                  local9.alternativa3d::drawId = local30;
                } else {
                  local12 = int(local9.alternativa3d::index);
                }
                alternativa3d::drawIndices[local29] = local10;
                local29++;
                alternativa3d::drawIndices[local29] = local11;
                local29++;
                alternativa3d::drawIndices[local29] = local12;
                local29++;
                local11 = local12;
                local32++;
                local8 = local8.alternativa3d::next;
              }
              local31++;
              if(local39 != null) {
                local8 = local39;
                while(local8 != null) {
                  local8.alternativa3d::vertex = null;
                  local8 = local8.alternativa3d::next;
                }
                param1.alternativa3d::lastWrapper.alternativa3d::next = local39;
                param1.alternativa3d::lastWrapper = local52;
                local39 = null;
              }
            }
            local5 = local6;
          }
          local34 *= 0.5;
          local23.length = local27;
          local24.length = local28;
          local25.length = local29;
          local20 = this.alternativa3d::mipMap[local40];
          if(this.correctUV) {
            local18 = -0.5 / (local20.width - 1);
            local19 = -0.5 / (local20.height - 1);
            local16 = 1 - local18 - local18;
            local17 = 1 - local19 - local19;
            local15 = 0;
            while(local15 < local28) {
              local24[local15] = local24[local15] * local16 + local18;
              local15++;
              local24[local15] = local24[local15] * local17 + local19;
              local15++;
              local15++;
            }
          }
          param2.alternativa3d::gfx.beginBitmapFill(local20,null,this.repeat,this.smooth);
          param2.alternativa3d::gfx.drawTriangles(local23,local25,local24,"none");
          local40--;
        }
      }
      param1.alternativa3d::numDraws = local30;
      param1.alternativa3d::numPolygons += local31;
      param1.alternativa3d::numTriangles += local32;
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      var local13:Face = null;
      var local14:Face = null;
      var local15:BitmapData = null;
      var local18:Number = NaN;
      var local19:int = 0;
      var local20:Wrapper = null;
      var local21:Vertex = null;
      var local22:int = 0;
      var local11:Number = Number(param1.alternativa3d::viewSizeX);
      var local12:Number = Number(param1.alternativa3d::viewSizeY);
      if(this.alternativa3d::_texture == null) {
        alternativa3d::clearLinks(param3);
        return;
      }
      if(this.alternativa3d::_mipMapping == 0) {
        local15 = this.alternativa3d::_texture;
      } else {
        local18 = param1.alternativa3d::focalLength * this.resolution;
        local19 = param4 >= local18 ? int(1 + Math.log(param4 / local18) * 1.4426950408889634) : 0;
        if(local19 >= this.alternativa3d::numMaps) {
          local19 = this.alternativa3d::numMaps - 1;
        }
        local15 = this.alternativa3d::mipMap[local19];
      }
      var local16:Number = local15.width;
      var local17:Number = local15.height;
      alternativa3d::drawMatrix.a = param5 / local16;
      alternativa3d::drawMatrix.b = param6 / local16;
      alternativa3d::drawMatrix.c = param7 / local17;
      alternativa3d::drawMatrix.d = param8 / local17;
      alternativa3d::drawMatrix.tx = param9;
      alternativa3d::drawMatrix.ty = param10;
      param2.alternativa3d::gfx.beginBitmapFill(local15,alternativa3d::drawMatrix,this.repeat,this.smooth);
      local13 = param3;
      while(local13 != null) {
        local14 = local13.alternativa3d::processNext;
        local13.alternativa3d::processNext = null;
        local20 = local13.alternativa3d::wrapper;
        local21 = local20.alternativa3d::vertex;
        param2.alternativa3d::gfx.moveTo(local21.alternativa3d::cameraX * local11 / param4,local21.alternativa3d::cameraY * local12 / param4);
        local22 = -1;
        local20 = local20.alternativa3d::next;
        while(local20 != null) {
          local21 = local20.alternativa3d::vertex;
          param2.alternativa3d::gfx.lineTo(local21.alternativa3d::cameraX * local11 / param4,local21.alternativa3d::cameraY * local12 / param4);
          local22++;
          local20 = local20.alternativa3d::next;
        }
        param1.alternativa3d::numTriangles += local22;
        ++param1.alternativa3d::numPolygons;
        local13 = local14;
      }
      ++param1.alternativa3d::numDraws;
    }

    public function disposeResource() : void {
    }
  }
}
