package trilateralGluonChange;

import gluon.webgl.GLContext;
import kitGL.gluon.Shaders;
import kitGL.gluon.HelpGL;
import kitGL.gluon.BufferGL;

import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.geom.FlatColorTriangles;
import trilateral3.nodule.PenNodule;

class AppGL{
    public var gl: GLContext;
    public var program: Program;
    public var pen: Pen;
    public var penNodule = new PenNodule();
    public var width:  Int;
    public var height: Int;
    public var buf: BufferGL;
    public
    function new( width_: Int, height_: Int ){
        width = width_;
        height = height_;
        creategl();
        setup();
    }
    inline
    function creategl( ){
        gl = new gluon.webgl.native.GLContext();
    }
    inline
    function setup(){
        program = programSetup( gl, vertexString0, fragmentString0 );
        draw( penNodule.pen );
        buf = interleaveXYZ_RGBA( gl
                                , program
                                , penNodule.data
                                , 'vertexPosition', 'vertexColor', true );
    }
    // override this for drawing initial scene
    public
    function draw( pen: Pen ){
    }
    @:keep
    static public function onFrame() {
        cpp.vm.Gc.run(true);
        var t_s = haxe.Timer.stamp();
        clearAll( gl, width, height );
        renderDraw( penNodule.pen );
        gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buf );
        gl.bufferSubData(RenderingContext.ARRAY_BUFFER, 0, cast penNodule.data );
        gl.useProgram( program );
        gl.drawArrays( RenderingContext.TRIANGLES, 0, penNodule.size );
    }
    // override this for drawing every frame or changing the data.
    public
    function renderDraw( pen: Pen ){
    }
}
