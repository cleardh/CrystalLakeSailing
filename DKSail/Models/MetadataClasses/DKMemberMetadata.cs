using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using DKClassLibrary;
using System.Text.RegularExpressions;

namespace DKSail.Models
{
    [ModelMetadataType(typeof(DKMemberMetadata))]
    public partial class Member : IValidatableObject
    {
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            FirstName = DKClassLibrary.DKValidations.DKCapitalize(FirstName.Trim());
            LastName = DKClassLibrary.DKValidations.DKCapitalize(LastName.Trim());

            if (SpouseFirstName != null)
            {
                SpouseFirstName = DKClassLibrary.DKValidations.DKCapitalize(SpouseFirstName.Trim());
            }
            if (SpouseLastName != null)
            {
                SpouseLastName = DKClassLibrary.DKValidations.DKCapitalize(SpouseLastName.Trim());
            }
            if (Street != null)
            {
                Street = DKClassLibrary.DKValidations.DKCapitalize(Street.Trim());
            }
            if (City != null)
            {
                City = DKClassLibrary.DKValidations.DKCapitalize(City.Trim());
            }
            if (ProvinceCode != null)
            {
                ProvinceCode = ProvinceCode.Trim().ToUpper();
            }
            if (PostalCode != null)
            {
                PostalCode = PostalCode.Trim().ToUpper();
            }
            if (HomePhone != null)
            {
                HomePhone = HomePhone.Trim();
            }
            if (Email != null)
            {
                Email = Email.Trim();
            }
            if (Comment != null)
            {
                Comment = Comment.Trim();
            }

            if (SpouseFirstName != null)
            {
                if (SpouseLastName != null)
                {
                    FullName = LastName + ", " + FirstName + " & " + SpouseLastName + ", " + SpouseFirstName;
                }
                else
                {
                    FullName = LastName + ", " + FirstName + " & " + SpouseFirstName;
                }
            }
            else
            {
                FullName = LastName + ", " + FirstName;
            }

            if (!string.IsNullOrWhiteSpace(PostalCode) && string.IsNullOrWhiteSpace(ProvinceCode))
            {
                yield return new ValidationResult("If postal code is provided, province code is required", new[] { nameof(PostalCode) });
            }

            var phone = DKClassLibrary.DKValidations.DKExtractDigits(HomePhone);
            if (phone.Length == 10)
            {
                HomePhone = phone.Insert(3, "-").Insert(7, "-"); ;
            }
            else
            {
                yield return new ValidationResult("Home phone should be exactly 10 digits", new[] { nameof(HomePhone) });
            }


            if (!ValidateEmail(Email))
            {
                yield return new ValidationResult("Email should be in the correct format", new[] { nameof(Email) });
            }


            if (YearJoined != null)
            {
                if (YearJoined > System.DateTime.Now.Year)
                {
                    yield return new ValidationResult("Year joined cannot be in the future", new[] { nameof(YearJoined) });
                }
            }


            if (!UseCanadaPost)
            {
                if (!ValidateEmail(Email) || string.IsNullOrWhiteSpace(Email))
                {
                    yield return new ValidationResult("If useCanadaPost is false, a valid email is required", new[] { nameof(Email) });
                }
            }
            else
            {
                if (string.IsNullOrWhiteSpace(PostalCode))
                {
                    yield return new ValidationResult("If useCanadaPost is true, a valid Postal code is required", new[] { nameof(PostalCode) });
                }
                if (!ValidateEmail(Email))
                {
                    yield return new ValidationResult("Email is invalid", new[] { nameof(Email) });
                }
            }

            var postalRef = PostalCode;
            if (DKClassLibrary.DKValidations.DKPostalCodeValidation(PostalCode))
            {
                PostalCode = DKClassLibrary.DKValidations.DKPostalCodeFormat(PostalCode);
            }
            else
            {
                if ((!DKClassLibrary.DKValidations.DKZipCodeValidation(ref postalRef)))
                {
                    yield return new ValidationResult("Postal code is invalid", new[] { nameof(PostalCode) });
                }
                PostalCode = postalRef;
            }


            yield return ValidationResult.Success;
        }

        private bool ValidateEmail(string email)
        {
            if (!string.IsNullOrWhiteSpace(email))
            {
                string emailPattern = @"^[A-Za-z0-9]{2,}@[A-Za-z0-9]{2,}.[A-Za-z0-9]{2,3}(.[A-Za-z0-9]{2,3})?$";

                if (!Regex.IsMatch(email.Trim(), emailPattern, RegexOptions.IgnoreCase))
                {
                    return false;
                }
            }

            return true;
        }
    }


    

    public class DKMemberMetadata
    {
        [Key]
        public int MemberId { get; set; }
        [Display(Name = "Member")]
        public string FullName { get; set; }
        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        [Display(Name = "Spouse First Name")]
        public string SpouseFirstName { get; set; }
        [Display(Name = "Spouse Last Name")]
        public string SpouseLastName { get; set; }
        [Display(Name = "Street Address")]
        public string Street { get; set; }
        public string City { get; set; }
        [Display(Name = "Province Code")]
        [Remote("ValidateProvinceCode","DKMember", AdditionalFields = "PostalCode")]
        public string ProvinceCode { get; set; }
        [Display(Name = "Postal Code")]
        [Remote("ValidatePostalCode","DKMember", AdditionalFields = "ProvinceCode")]
        [RegularExpression(@"\S+", ErrorMessage = "White spaces with no actual input are not allowed")]
        public string PostalCode { get; set; }
        [Required]
        [Display(Name = "Home Phone")]
        public string HomePhone { get; set; }
        public string Email { get; set; }
        [Display(Name = "Year Joined")]
        public int? YearJoined { get; set; }
        [Display(Name = "Comments")]
        public string Comment { get; set; }
        [Display(Name = "Task Exempt?")]
        public bool TaskExempt { get; set; }
        [Display(Name = "Use Canada Post?")]
        public bool UseCanadaPost { get; set; }
    }
}
