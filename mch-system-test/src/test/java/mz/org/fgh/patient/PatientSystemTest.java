/*
 * MozView Technologies, Lda. 2010 - 2015
 */
package mz.org.fgh.patient;

import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import mz.org.fgh.config.SeleniumManager;
import mz.org.fgh.login.LoginPage;

/**
 * @author Stélio Moiane
 *
 */
public class PatientSystemTest {

	private SeleniumManager seleniumManager;

	@Before
	public void setUp() {
		this.seleniumManager = new SeleniumManager();
	}

	@Test
	public void shouldFindPatientByName() {
		final PatientPage patientPage = new PatientPage(this.seleniumManager);
		new LoginPage(this.seleniumManager).logAsAdmin("Admin", "Openmrsadmin04");

		patientPage.findPatientPage();

		patientPage.findPatientByName("flor");

		assertTrue(patientPage.wasPatientFound("Flor de Liz"));
	}

	@After
	public void tearDown() {
		this.seleniumManager.closeDriver();
	}
}
