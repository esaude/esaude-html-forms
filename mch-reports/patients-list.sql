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

#LISTA DE GESTANTES QUE FIZERAM O PRIMEIRO TESTE
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



#LISTA DE GESTANTES HIV+ (NO PRIMEIRO TESTE E NO SEGUINTE)
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id
	INNER JOIN concept c on o.value_coded = c.concept_id
	WHERE c.uuid = 'e1d47386-1d5f-11e0-b929-000c29ad1d07'
	AND et.uuid = 'e278ff3c-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;


#LISTA DE GESTANTES EM PROFILAXIA OU TARV
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


#LISTA DE GESTANTES HIV+ SEM INÍCIO DE DE PROFILAXIA OU TARV
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID, p.patient_id FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id
	INNER JOIN concept c on o.value_coded = c.concept_id
	INNER JOIN 
	(
		select p.patient_id from patient p
		INNER JOIN person pe on p.patient_id = pe.person_id
		INNER JOIN encounter e on e.patient_id = p.patient_id
		INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
		INNER JOIN obs o on o.person_id = pe.person_id
		INNER JOIN concept c on o.value_coded = c.concept_id
		WHERE c.uuid NOT IN ('e1d9ef28-1d5f-11e0-b929-000c29ad1d07', 'b8641d6a-1dea-48b4-8f02-c7547fb6fdf4')
		AND p.voided = 0
		AND e.voided  = 0
	) patient_without_tarv_prophlaxis on patient_without_tarv_prophlaxis.patient_id = p.patient_id 
	
	WHERE c.uuid IN ('b8641d6a-1dea-48b4-8f02-c7547fb6fdf4', '3e7dd749-bc16-4ce6-b475-0418c56d4412')
	AND et.uuid = 'e278ff3c-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;



#LISTA DE CRIANÇAS EXPOSTAS
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id

	INNER JOIN (
			SELECT o.obs_id FROM obs o
			INNER JOIN concept c on c.concept_id = o.concept_id
			WHERE c.uuid = 'e1dc9ade-1d5f-11e0-b929-000c29ad1d07'
		) exposed_obs on exposed_obs.obs_id = o.obs_id

	INNER JOIN concept c on o.value_coded = c.concept_id

	WHERE c.uuid = 'e1d81b62-1d5f-11e0-b929-000c29ad1d07'
	AND et.uuid = 'e278fe10-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;

#LISTA DE CRIANÇAS QUE FIZERAM PCR
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id

	INNER JOIN (
			SELECT o.person_id FROM obs o
			INNER JOIN concept c on c.concept_id = o.concept_id
			WHERE c.uuid IN ('f28f4768-ac74-43ea-b224-f5320c700c35', 'f4ef8d2e-156f-43ba-8e3f-7e25c6948883')
		) pcr on pcr.person_id = pe.person_id

	INNER JOIN concept c on o.value_coded = c.concept_id
	
	WHERE c.uuid = 'e1d81b62-1d5f-11e0-b929-000c29ad1d07'
	AND et.uuid = 'e278fe10-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;

#LISTA DE CRIANÇAS QUE INICIARAM CTZ
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id

	INNER JOIN (
			SELECT o.person_id FROM obs o
			INNER JOIN concept c on c.concept_id = o.value_coded
			WHERE o.value_coded IN ('464e4b21-178a-4f66-b677-acfa72ece904', '0dae71c4-167c-4691-82b7-6742655bb2cd')
		) ctz on ctz.person_id = pe.person_id

	INNER JOIN concept c on o.concept_id = c.concept_id
	
	WHERE c.uuid = '2616b3c9-9a99-4b9a-b673-10871f4a4c71'
	AND et.uuid = 'e278fe10-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;

#LISTA DE CRIANÇAS NÃO EXPOSTAS COM PCR
SELECT concat(ifnull(pn.given_name,''),' ',ifnull(pn.middle_name,''),' ',ifnull(pn.family_name,'')) NomeCompleto, pi.identifier NID FROM patient p
	INNER JOIN person pe on p.patient_id = pe.person_id
	INNER JOIN person_name pn on pn.person_id = pe.person_id
	INNER JOIN patient_identifier pi on pi.patient_id = p.patient_id
	INNER JOIN encounter e on e.patient_id = p.patient_id
	INNER JOIN encounter_type et on e.encounter_type = et.encounter_type_id
	INNER JOIN obs o on o.person_id = pe.person_id

	INNER JOIN (
			SELECT o.person_id FROM obs o
			INNER JOIN concept c on c.concept_id = o.concept_id
			WHERE c.uuid IN ('f28f4768-ac74-43ea-b224-f5320c700c35', 'f4ef8d2e-156f-43ba-8e3f-7e25c6948883')
		) pcr on pcr.person_id = pe.person_id

	INNER JOIN (
			SELECT o.person_id FROM obs o
			INNER JOIN concept c on c.concept_id = o.concept_id
			WHERE c.uuid = 'e1dc9ade-1d5f-11e0-b929-000c29ad1d07'
			AND o.value_coded = 1066
		)not_exposed on not_exposed.person_id = pe.person_id

	INNER JOIN concept c on o.value_coded = c.concept_id
	
	WHERE c.uuid = 'e1d81b62-1d5f-11e0-b929-000c29ad1d07'
	AND et.uuid = 'e278fe10-1d5f-11e0-b929-000c29ad1d07'
	AND e.encounter_datetime between :startDate and :endDate and e.location_id=:location
	AND p.voided = 0
	AND e.voided  = 0
	GROUP by NomeCompleto;
