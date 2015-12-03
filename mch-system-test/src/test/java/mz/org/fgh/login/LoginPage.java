/*
 * MozView Technologies, Lda. 2010 - 2015
 */
package mz.org.fgh.login;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import mz.org.fgh.config.SeleniumManager;

/**
 * @author Stélio Moiane
 *
 */
public class LoginPage {

	@FindBy(id = "username")
	private WebElement username;

	@FindBy(id = "password")
	private WebElement password;

	private final SeleniumManager seleniumManager;

	public LoginPage(final SeleniumManager seleniumManager) {
		this.seleniumManager = seleniumManager;
		seleniumManager.initElements(this);
	}

	public void logAsAdmin(final String username, final String password) {

		this.seleniumManager.index();

		this.username.sendKeys(username);
		this.password.sendKeys(password);

		this.username.submit();
	}

	public boolean userIsLogged(final String welcome) {
		final WebElement element = this.seleniumManager.getDriver().findElement(By.id("userLoggedInAs"));
		return element.getText().equals(welcome);
	}
}
