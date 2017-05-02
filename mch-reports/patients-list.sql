# LISTA GESTANTES NOVAS INSCRITAS
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id
	INNER JOIN concept c on o.value_coded = c.concept_id
	WHERE c.uuid = 'ea828b7f-1208-487b-b4c0-5e050e0ac7bc'
	AND et.uuid = 'e278ff3c-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;

#GESTANTES QUE FIZERAM O PRIMEIRO TESTE
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id
	INNER JOIN concept c on o.value_coded = c.concept_id
	WHERE c.uuid IN ('e1d446cc-1d5f-11e0-b929-000c29ad1d07', 'e1d47386-1d5f-11e0-b929-000c29ad1d07', 'e1d446cc-1d5f-11e0-b929-000c29ad1d07')
	AND et.uuid = 'e278ff3c-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;


#GESTANTES EM PROFILAXIA OU TARV
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id
	INNER JOIN concept c on o.value_coded = c.concept_id
	WHERE c.uuid IN ('b8641d6a-1dea-48b4-8f02-c7547fb6fdf4', '3e7dd749-bc16-4ce6-b475-0418c56d4412')
	AND et.uuid = 'e278ff3c-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;