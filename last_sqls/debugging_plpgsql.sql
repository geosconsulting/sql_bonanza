CREATE OR REPLACE FUNCTION format_us_full_name_debug(
   prefix text,
   firstname text,
   mi text,
   lastname text,
   suffix text)
RETURNS text AS
$BODY$
DECLARE
   fname_mi text;
   fmi_lname text;
   prefix_fmil text;
   pfmil_suffix text;
   BEGIN
    fname_mi := CONCAT_WS(' ', CASE trim(firstname) WHEN '' THEN NULL
    ELSE firstname END, CASE trim(mi) WHEN '' THEN NULL ELSE mi END || '.');
       RAISE NOTICE 'firstname mi.: %', fname_mi;
    fmi_lname := CONCAT_WS(' ', CASE fname_mi WHEN '' THEN NULL ELSE
    fname_mi END,CASE trim(lastname) WHEN '' THEN NULL ELSE lastname END);
     RAISE NOTICE 'firstname mi. lastname: %', fmi_lname;
    prefix_fmil := CONCAT_WS('. ', CASE trim(prefix) WHEN '' THEN NULL
   ELSE prefix END, CASE fmi_lname WHEN '' THEN NULL ELSE fmi_lname END);
   RAISE NOTICE 'prefix. firstname mi lastname: %', prefix_fmil;
     pfmil_suffix := CONCAT_WS(', ', CASE prefix_fmil WHEN '' THEN NULL
   ELSE prefix_fmil END, CASE trim(suffix) WHEN '' THEN NULL ELSE suffix || '.' END);
  RAISE NOTICE 'prefix. firstname mi lastname, suffix.: %', pfmil_suffix;
RETURN pfmil_suffix;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

SELECT format_us_full_name_debug('Mr','Kirk','L','Roybal','Author');

CREATE OR REPLACE FUNCTION validate_us_zip(zipcode TEXT)
RETURNS boolean
AS $$
DECLARE
digits text;
BEGIN
-- remove anything that is not a digit (POSIX compliantly, please)
digits := (SELECT regexp_replace(zipcode,'[^[:digit:]]','','g'));
IF digits = '' THEN
RAISE EXCEPTION 'Zipcode does not contain any digits --> %',
digits USING HINT = 'Is this a US zip code?', ERRCODE = 'P9999';
ELSIF length(digits) < 5 THEN
RAISE EXCEPTION 'Zipcode does not contain enough digits --> %',
digits USING HINT = 'Zip code has less than 5 digits.', ERRCODE =
'P9998';
ELSIF length(digits) > 9 THEN
RAISE EXCEPTION 'Unnecessary digits in zip code --> %', digits
USING HINT = 'Zip code is more than 9 digits.', ERRCODE = 'P9997';
ELSIF length(digits) > 5 AND length(digits) < 9 THEN
RAISE EXCEPTION 'Zip code cannot be processed --> %', digits USING
HINT = 'Zip code abnormal length.', ERRCODE = 'P9996';
ELSE
RETURN true;
END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_us_zip_validation_status(zipcode text)
returns text
AS
$$
BEGIN
SELECT validate_us_zip(zipcode);
RETURN 'Passed Validation';
EXCEPTION
WHEN SQLSTATE 'P9999' THEN RETURN 'Non-US Zip Code';
WHEN SQLSTATE 'P9998' THEN RETURN 'Not enough digits.';
WHEN SQLSTATE 'P9997' THEN RETURN 'Too many digits.';
WHEN SQLSTATE 'P9996' THEN RETURN 'Between 6 and 8 digits.';
RAISE; -- Some other SQL error.
END;
$$
LANGUAGE 'plpgsql';

SELECT get_us_zip_validation_status('34955');

CREATE EXTENSION pldbgapi;