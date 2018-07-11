SELECT UpdateGeometrySRID('public', 'burntAreaForecast', 'geom', 4326);
ALTER TABLE public."burntAreaForecast" ADD CONSTRAINT enforce_srid_the_geom CHECK (st_srid(geom) = (4326));