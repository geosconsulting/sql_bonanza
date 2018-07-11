SELECT ST_Distance(
ST_SetSRID(ST_MakePoint(367201,5817855),32633),
ST_SetSRID(ST_MakePoint(391390,5807271),32633)
)

-- se in lat long and the geometry type is used, it can be cast to geography:
SELECT ST_Distance(ST_MakePoint(20,50)::geography,ST_MakePoint(21,51)::geography);

--use_spheroid = FALSE
SELECT ST_Distance(ST_MakePoint(20,50)::geography,ST_MakePoint(21,51)::geography,FALSE);

SELECT ST_Perimeter(ST_GeomFromText('POLYGON((391390 5817855,391490
5817955,391590 5818055, 319590 5817855,391390 5817855))', 32633))

-- Again, for latitude-longitude coordinates, the geography type should be used.
SELECT ST_Perimeter(
ST_MakePolygon(ST_MakeLine(ARRAY[ST_MakePoint(20,50),ST_MakePoint(19.95,49.98), 
ST_MakePoint(19.90,49.90),ST_MakePoint(20,50)]))::geography
);

SELECT ST_Extent(
ST_GeomFromText('POLYGON((391390 5817855,391490 5817955,391590 5818055,
319590 5817855,391390 5817855))', 32633)
);