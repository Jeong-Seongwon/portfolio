package user;

public class UserVO {

	private String id;
	private String password;
	private String name;
	private String birth;
	private String gender;
	private String email;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		if (birth!=null && birth.length()>=10) {
			return birth.substring(0, 10);
		} else {
			return null;
		}
	}
	public void setBirth(String birth) {
		if (birth != null) {
			this.birth = birth;
		}
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
