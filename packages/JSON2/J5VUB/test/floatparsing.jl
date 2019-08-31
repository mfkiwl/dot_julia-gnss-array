floats = [
    5e-324,
    1.7976931348623157e308,
    4294967272.0,
    4.1855804968213567e298,
    5.5626846462680035e-309,
    2147483648.0,
    3.5844466002796428e+298,
    reinterpret(Float64, 0x0010000000000000),
    reinterpret(Float64, 0x000FFFFFFFFFFFFF),
    Float32(1e-45),
    3.4028234f38,
    Float32(4294967272.0),
    Float32(3.32306998946228968226e+35),
    Float32(1.2341e-41),
    Float32(3.3554432e7),
    Float32(3.26494756798464e14),
    Float32(3.91132223637771935344e37),
    reinterpret(Float32, 0x00800000),
    reinterpret(Float32, 0x007FFFFF),
    1.0,
    1.5,
    # 3.3161339052167390562200598e-237,
    7.9885183916008099497815232e+191,
    Float64(0xFFFFFFFF),
    1e21,
    999999999999999868928.00,
    6.9999999999999989514240000e+21,
    1.55,
    1.00000001,
    0.1,
    0.01,
    0.001,
    0.0001,
    0.00001,
    0.000001,
    0.0000001,
    0.00000001,
    0.000000001,
    0.0000000001,
    0.00000000001,
    0.000000000001,
    0.0000000000001,
    0.00000000000001,
    0.000000000000001,
    0.0000000000000001,
    0.00000000000000001,
    0.000000000000000001,
    0.0000000000000000001,
    0.00000000000000000001,
    0.10000000004,
    0.00010000004,
    0.00001000004,
    0.00000100004,
    0.00000010004,
    0.00000001004,
    0.00000000104,
    0.0000000001000004,
    0.0000000000100004,
    0.0000000000010004,
    0.0000000000001004,
    0.0000000000000104,
    0.6,
    0.96,
    0.996,
    0.9996,
    0.99996,
    0.999996,
    0.9999996,
    0.99999996,
    0.999999996,
    0.9999999996,
    0.99999999996,
    0.999999999996,
    0.9999999999996,
    0.99999999999996,
    0.999999999999996,
    0.9999999999999996,
    0.00999999999999996,
    0.000999999999999996,
    0.0000999999999999996,
    0.00000999999999999996,
    0.000000999999999999996,
    323423.234234,
    12345678.901234,
    98765.432109,
    42,
    0.5,
    1e-23,
    1e-123,
    1e-123,
    1e-23,
    1e-21,
    1e-22,
    6e-21,
    9.1193616301674545152000000e+19,
    4.8184662102767651659096515e-04,
    1.9023164229540652612705182e-23,
    1000000000000000128.0,
    floatmin(Float16),
    floatmax(Float16),
    Float16(1.0),
    Float16(1.5),
    Float16(1.55),
    Float16(1.00000001),
    Float16(0.1),
    Float16(0.01),
    Float16(0.001),
    Float16(0.0001),
    Float16(0.00001),
    Float16(0.000001),
    Float16(0.0000001),
    Float16(0.6),
    Float16(0.96),
    Float16(0.996),
    Float16(0.9996),
    Float16(0.99996),
    Float16(0.999996),
    Float16(0.9999996),
    Float16(0.99999996),
    Float16(42),
    Float16(0.5),
]
for f in floats
    try
        @test JSON2.read(JSON2.write(f), typeof(f)) == f
    catch
        println("parsing $(typeof(f)) '$f' failed")
    end
end

for F in (Float16, Float32, Float64)
    for f in rand(F, 100)
        try
            @test JSON2.read(JSON2.write(f), F) == f
        catch
            println("parsing $(typeof(f)) '$f' failed")
        end
    end
end