# LISTA GESTANTES NOVAS INSCRITAS
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 11
	AND c.concept_id = 6361
	AND o.value_coded = 6355
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;


#LISTA DE GESTANTES QUE FIZERAM O PRIMEIRO TESTE
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 11
	AND c.concept_id = 2079
	AND o.value_coded IN (664,703,1138)
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;


#LISTA DE GESTANTES HIV+ (NO PRIMEIRO TESTE E NO SEGUINTE)
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 11
	AND c.concept_id = 2079
	AND o.value_coded IN (664,703,1138)
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;


#LISTA DE GESTANTES EM PROFILAXIA OU TARV
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 11
	AND c.concept_id = 1504
	AND o.value_coded IN (6388,631,1801,1256)
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;


#LISTA DE GESTANTES HIV+ SEM INÍCIO DE DE PROFILAXIA OU TARV
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	INNER JOIN
	(
		SELECT p1.patient_id FROM patient p1
			INNER JOIN encounter e1 on e1.patient_id = p1.patient_id
			INNER JOIN obs o1 on o1.encounter_id = e1.encounter_id
			INNER JOIN concept c1 on o1.concept_id = c1.concept_id
			INNER JOIN encounter_type et1 on et1.encounter_type_id = e1.encounter_type
			INNER JOIN location l1 on l1.location_id = o1.location_id
				WHERE et1.encounter_type_id = 11
					AND c1.concept_id = 1504
					AND o1.value_coded NOT IN (6388,631,1801,1256)
					AND p1.voided = 0
					AND o1.voided = 0
	)without_prophlaxis on without_prophlaxis.patient_id = p.patient_id 
	WHERE et.encounter_type_id = 11
		AND c.concept_id = 2079
		AND o.value_coded = 703
		AND e.encounter_datetime BETWEEN :startDate AND :endDate
		AND l.location_id = :location
		AND p.voided = 0
		AND o.voided = 0
		AND pi.preferred = 1
		AND pn.voided = 0
		ORDER BY NomeCompleto ASC;


# VALIDACAO - GESTANTES HIV NEGATIVO COM INÍCIO DE TARV OU PROFILAXIA
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	INNER JOIN
	(
		SELECT p1.patient_id FROM patient p1
			INNER JOIN encounter e1 on e1.patient_id = p1.patient_id
			INNER JOIN obs o1 on o1.encounter_id = e1.encounter_id
			INNER JOIN concept c1 on o1.concept_id = c1.concept_id
			INNER JOIN encounter_type et1 on et1.encounter_type_id = e1.encounter_type
			INNER JOIN location l1 on l1.location_id = o1.location_id
				WHERE et1.encounter_type_id = 11
					AND c1.concept_id = 1504
					AND o1.value_coded IN (6388,631,1801,1256)
					AND p1.voided = 0
					AND o1.voided = 0
	)without_prophlaxis on without_prophlaxis.patient_id = p.patient_id 
	WHERE et.encounter_type_id = 11
		AND c.concept_id = 2079
		AND o.value_coded = 664
		AND e.encounter_datetime BETWEEN :startDate AND :endDate
		AND l.location_id = :location
		AND p.voided = 0
		AND o.voided = 0
		AND pi.preferred = 1
		AND pn.voided = 0
		ORDER BY NomeCompleto ASC;


#LISTA DE CRIANÇAS EXPOSTAS
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id = 1586
	AND o.value_coded = 1065
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;

#LISTA DE CRIANÇAS QUE FIZERAM PCR
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id in (6414, 6415)
	AND o.value_coded = 1065
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;

#LISTA DE CRIANÇAS QUE INICIARAM CTZ
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id = 6121
	AND o.value_coded IN (6411, 6412)
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;

#LISTA DE CRIANÇAS NÃO EXPOSTAS COM PCR
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	INNER JOIN 
	(
		SELECT p1.patient_id FROM patient p1
			INNER JOIN encounter e1 on e1.patient_id = p1.patient_id
			INNER JOIN obs o1 on o1.encounter_id = e1.encounter_id
			INNER JOIN concept c1 on o1.concept_id = c1.concept_id
			INNER JOIN encounter_type et1 on et1.encounter_type_id = e1.encounter_type
				WHERE et1.encounter_type_id = 10
					AND c1.concept_id IN (6414, 6415)
					AND o1.value_coded = 1065
					AND p1.voided = 0
					AND o1.voided = 0
		
	)pcr on pcr.patient_id = p.patient_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id = 1586
	AND o.value_coded = 1066
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	ORDER BY NomeCompleto ASC;

#CRIANCAS COM PCR POSITIVO SEM NID TARV
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id  IN (6416, 6417)
	AND o.value_coded = 703
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	AND NOT EXISTS
	(
	  SELECT p1.patient_id FROM patient p1
		INNER JOIN patient_identifier pi1 on pi1.patient_id = p1.patient_id
		INNER JOIN patient_identifier_type pit1 on pit1.patient_identifier_type_id = pi1.identifier_type
			WHERE  pit1.patient_identifier_type_id = 2
				AND p.patient_id = p1.patient_id
				AND pi1.voided = 0
	)
	ORDER BY NomeCompleto ASC;

#CRIANCAS EXPOSTAS SEM INICIO DE CTZ
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	INNER JOIN 
	(
		SELECT p1.patient_id FROM patient p1
			INNER JOIN encounter e1 on e1.patient_id = p1.patient_id
			INNER JOIN obs o1 on o1.encounter_id = e1.encounter_id
			INNER JOIN concept c1 on o1.concept_id = c1.concept_id
			INNER JOIN encounter_type et1 on et1.encounter_type_id = e1.encounter_type
				WHERE et1.encounter_type_id = 10
					AND c1.concept_id = 6121
					AND o1.value_coded = 6387
					AND p1.voided = 0
					AND o1.voided = 0
		
	)pcr on pcr.patient_id = p.patient_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id = 1586
	AND o.value_coded = 1065
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	GROUP BY NomeCompleto
	ORDER BY NomeCompleto ASC;

#CRIANCAS EXPOSTAS SEM PCR
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier as NID FROM patient p
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN obs o on o.encounter_id = e.encounter_id
	INNER JOIN concept c on o.concept_id = c.concept_id
	INNER JOIN encounter_type et on et.encounter_type_id = e.encounter_type
	INNER JOIN location l on l.location_id = o.location_id
	INNER JOIN 
	(
		SELECT p1.patient_id FROM patient p1
			INNER JOIN encounter e1 on e1.patient_id = p1.patient_id
			INNER JOIN obs o1 on o1.encounter_id = e1.encounter_id
			INNER JOIN concept c1 on o1.concept_id = c1.concept_id
			INNER JOIN encounter_type et1 on et1.encounter_type_id = e1.encounter_type
				WHERE et1.encounter_type_id = 10
					AND c1.concept_id IN (6414, 6415)
					AND o1.value_coded = 1066
					AND p1.voided = 0
					AND o1.voided = 0
		
	)pcr on pcr.patient_id = p.patient_id
	WHERE et.encounter_type_id = 10
	AND c.concept_id = 1586
	AND o.value_coded = 1065
	AND e.encounter_datetime BETWEEN :startDate AND :endDate
	AND l.location_id = :location
	AND p.voided = 0
	AND o.voided = 0
	AND pi.preferred = 1
	AND pn.voided = 0
	GROUP BY NomeCompleto
	ORDER BY NomeCompleto ASC;