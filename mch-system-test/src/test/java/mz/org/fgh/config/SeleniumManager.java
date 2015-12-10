/*
 * MozView Technologies, Lda. 2010 - 2015
 */
package mz.org.fgh.config;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriver.Window;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.PageFactory;

/**
 * @author Stélio Moiane
 *		
 */
public class SeleniumManager {
	
	private final WebDriver driver;
	private final Window window;
	private static final String BASE_URL = "http://localhost:8080/openmrs";
	
	public SeleniumManager() {
		this.driver = new FirefoxDriver();
		this.driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		this.window = this.driver.manage().window();
	}
	
	public void index() {
		this.driver.get(BASE_URL);
		this.window.maximize();
	}
	
	public WebDriver getDriver() {
		return this.driver;
	}
	
	public void initElements(final Object object) {
		PageFactory.initElements(this.driver, object);
	}
	
	public void closeDriver() {
		this.driver.close();
	}
}
