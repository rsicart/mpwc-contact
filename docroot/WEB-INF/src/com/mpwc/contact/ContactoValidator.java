package com.mpwc.contact;


import java.util.List;
import com.liferay.portal.kernel.util.Validator;
import com.mpwc.model.Contacto;

public class ContactoValidator {
	
    /**
     * Validates a Contacto object.
     */
    public static boolean validate(Contacto c, List errors) {

        boolean valid = true;

        if (Validator.isNull(c.getContactoId())) {
            errors.add("error-firmname-notvalid");
            valid = false;
        }
        
        if (Validator.isNull(c.getFirmname())) {
            errors.add("error-firmname-notvalid");
            valid = false;
        }

        if (Validator.isNull(c.getNif()) || !Validator.isAlphanumericName(c.getNif()) ) {
            errors.add("error-nif-notvalid");
            valid = false;
        }
        
        if(Validator.isNull(c.getEmail()) || !Validator.isEmailAddress(c.getEmail()) ) {
            errors.add("error-email-notvalid");
            valid = false;
        }

        if(Validator.isNull(c.getAddress()) ) {
            errors.add("error-email-notvalid");
            valid = false;
        }
        
        if( Validator.isNull(c.getCity()) ) {
                errors.add("error-email-notvalid");
                valid = false;
        }
        
        if ( Validator.isNull(c.getZipcode()) || !Validator.isDigit(c.getZipcode()) ) {
                errors.add("error-zipcode-notvalid");
                valid = false;
        }
        
        if ( Validator.isNull(c.getCountry()) ) {
            errors.add("error-country-notvalid");
            valid = false;
        }

        if (Validator.isNull(c.getPhone()) || !Validator.isPhoneNumber(c.getPhone()) ) {
            errors.add("error-phone-notvalid");
            valid = false;
        }
        
        if (Validator.isNotNull(c.getPhone2()) && !Validator.isPhoneNumber(c.getPhone2()) ) {
            errors.add("error-phone2-notvalid");
            valid = false;
        }
        
        if (Validator.isNull(c.getContactoStatusId()) ) {
            errors.add("error-status-notvalid");
            valid = false;
        }


        return valid;

    }


}
