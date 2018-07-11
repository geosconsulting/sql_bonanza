create extension plpythonu;

create extension postgis;
create extension postgis_topology;
 
DROP extension madlib;
create extension madlib;

DROP TABLE IF EXISTS patients, patients_logregr, patients_logregr_summary;

CREATE TABLE patients( id INTEGER NOT NULL,
                        second_attack INTEGER,
                        treatment INTEGER,
                        trait_anxiety INTEGER);

INSERT INTO patients VALUES                                                     
(1,     1,      1,      70),
(3,     1,      1,      50),
(5,     1,      0,      40),
(7,     1,      0,      75),
(9,     1,      0,      70),
(11,    0,      1,      65),
(13,    0,      1,      45),
(15,    0,      1,      40),
(17,    0,      0,      55),
(19,    0,      0,      50),
(2,     1,      1,      80),
(4,     1,      0,      60),
(6,     1,      0,      65),
(8,     1,      0,      80),
(10,    1,      0,      60),
(12,    0,      1,      50),
(14,    0,      1,      35),
(16,    0,      1,      50),
(18,    0,      0,      45),
(20,    0,      0,      60);

SELECT logregr_train(
    'patients',                                 -- source table
    'patients_logregr',                         -- output table
    'second_attack',                            -- labels
    'ARRAY[1, treatment, trait_anxiety]',       -- features
    NULL,                                       -- grouping columns
    20,                                         -- max number of iteration
    'irls'                                      -- optimizer
    );

select * from patients_logregr;

SELECT unnest(array['intercept', 'treatment', 'trait_anxiety']) as attribute,
        unnest(coef) as coefficient,
        unnest(std_err) as standard_error,
        unnest(z_stats) as z_stat,
        unnest(p_values) as pvalue,
        unnest(odds_ratios) as odds_ratio
 FROM patients_logregr;

-- Display prediction value along with the original value
SELECT p.id, logregr_predict(coef, ARRAY[1, treatment, trait_anxiety]),
       p.second_attack
FROM patients p, patients_logregr m
ORDER BY p.id;

-- Predicting the probability of the dependent variable being TRUE.
-- Display prediction value along with the original value
SELECT p.id, logregr_predict_prob(coef, ARRAY[1, treatment, trait_anxiety])
FROM patients p, patients_logregr m
ORDER BY p.id;

