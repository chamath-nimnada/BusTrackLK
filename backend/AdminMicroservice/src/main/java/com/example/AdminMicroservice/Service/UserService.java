package com.example.AdminMicroservice.Service;




import com.example.AdminMicroservice.Model.User;
import com.example.AdminMicroservice.Repository.UserRepository;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // This method verifies the Firebase token (from frontend)
    public User verifyToken(String idToken) throws FirebaseAuthException {
        FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);

        User user = new User();
        user.setUid(decodedToken.getUid());
        user.setEmail(decodedToken.getEmail());
        user.setDisplayName((String) decodedToken.getClaims().get("name"));
        user.setToken(idToken);

        try {
            userRepository.saveUser(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}