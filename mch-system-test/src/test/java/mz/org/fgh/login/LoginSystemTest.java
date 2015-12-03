/*
 * MozView Technologies, Lda. 2010 - 2015
 */
package mz.org.fgh.login;

import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import mz.org.fgh.config.SeleniumManager;

/**
 * @author Stélio Moiane
 * 		
 */
public class LoginSystemTest {

	private SeleniumManager seleniumManager;

	@Before
	public void setUp() {
		this.seleniumManager = new SeleniumManager();
	}

	@Test
	public void shouldLoginToOpenMrsAsAdmin() {

		final LoginPage loginPage = new LoginPage(this.seleniumManager);

		loginPage.logAsAdmin("Admin", "Openmrsadmin04");

		assertTrue(loginPage.userIsLogged("Currently logged in as Super User"));
	}

	@After
	public void tearDown() {
		this.seleniumManager.closeDriver();
	}
}
