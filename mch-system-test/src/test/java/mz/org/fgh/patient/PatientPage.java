/*
 * MozView Technologies, Lda. 2010 - 2015
 */
package mz.org.fgh.patient;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import mz.org.fgh.config.SeleniumManager;

/**
 * @author Stélio Moiane
 *		
 */
public class PatientPage {

	@FindBy(linkText = "Find/Create Patient")
	private WebElement patientLink;

	@FindBy(id = "inputNode")
	private WebElement patientName;

	private final SeleniumManager seleniumManager;

	public PatientPage(final SeleniumManager seleniumManager) {
		this.seleniumManager = seleniumManager;
		seleniumManager.initElements(this);
	}

	public void findPatientPage() {
		this.patientLink.click();
	}

	public void findPatientByName(final String patientPartsOfName) {
		this.patientName.sendKeys(patientPartsOfName);
		final List<WebElement> elements = this.seleniumManager.getDriver().findElements(By.cssSelector(".odd"));
		final WebElement webElement = elements.get(0);
		webElement.click();
	}

	public boolean wasPatientFound(final String string) {
		return this.seleniumManager.getDriver().findElement(By.id("patientHeaderPatientName")).isDisplayed();
	}
}
