# MCH - System Test

With this project is possible to run and create funcional tests for the MCH module.

The Java project was created on Maven and the functional or system tests if you prefer a based on Selenium frameworks.

#How create new testes?
 In the a text file or on the IDE of your choice.
 Create a text class like:

 public class LoginSystemTest {

	private SeleniumManager seleniumManager;

	@Before
	public void setUp() {
		this.seleniumManager = new SeleniumManager();
	}

	@Test
	public void shouldLoginToOpenMrsAsAdmin() {

		final LoginPage loginPage = new LoginPage(this.seleniumManager);

		loginPage.logAsAdmin("Admin", "password");

		assertTrue(loginPage.userIsLogged("Currently logged in as Super User"));
	}

	@After
	public void tearDown() {
		this.seleniumManager.closeDriver();
	}
}

The seleniumManager class was created to handle general configurations tha can be changed in case of need.
To normalize de development and easy mantainance, all test class should follow the PageObject pattern like the example below.

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

All the text suite can be executed using the following command:
mvn clean test