<?php

namespace NABC\AdminBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Business
 *
 * @ORM\Table(name="business")
 * @ORM\Entity
 */
class Business
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="address", type="string", length=255)
     */
    private $address;

    /**
     * @var string
     *
     * @ORM\Column(name="businessAddress", type="string", length=255)
     */
    private $businessAddress;

    /**
     * @var string
     *
     * @ORM\Column(name="businessDescription", type="text", nullable=true)
     */
    private $businessDescription;

    /**
     * @var string
     *
     * @ORM\Column(name="businessSuiteApt", type="string", length=255, nullable=true)
     */
    private $businessSuiteApt;

    /**
     * @var string
     *
     * @ORM\Column(name="businessZipCode", type="string", length=255)
     */
    private $businessZipCode;

    /**
     * @var string
     *
     * @ORM\Column(name="ccSales", type="string", length=255)
     */
    private $ccSales;

    /**
     * @var string
     *
     * @ORM\Column(name="corporationName", type="string", length=255, nullable=true)
     */
    private $corporationName;

    /**
     * @var string
     *
     * @ORM\Column(name="dba", type="string", length=255, nullable=true)
     */
    private $dba;

    /**
     * @var string
     *
     * @ORM\Column(name="dob", type="string", length=255)
     */
    private $dob;

    /**
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=255)
     */
    private $email;

    /**
     * @var string
     *
     * @ORM\Column(name="fedTaxId", type="string", length=255, nullable=true)
     */
    private $fedTaxId;

    /**
     * @var string
     *
     * @ORM\Column(name="firstName", type="string", length=255)
     */
    private $firstName;

    /**
     * @var string
     *
     * @ORM\Column(name="highestSales", type="string", length=255)
     */
    private $highestSales;

    /**
     * @var string
     *
     * @ORM\Column(name="lastName", type="string", length=255)
     */
    private $lastName;

    /**
     * @var string
     *
     * @ORM\Column(name="phoneNumber", type="string", length=255)
     */
    private $phoneNumber;

    /**
     * @var string
     *
     * @ORM\Column(name="ssn", type="string", length=255)
     */
    private $ssn;

    /**
     * @var string
     *
     * @ORM\Column(name="suiteApt", type="string", length=255, nullable=true)
     */
    private $suiteApt;

    /**
     * @var string
     *
     * @ORM\Column(name="type", type="string", length=255, nullable=true)
     */
    private $type;

    /**
     * @var string
     *
     * @ORM\Column(name="yearInBusiness", type="string", length=255, nullable=true)
     */
    private $yearInBusiness;

    /**
     * @var string
     *
     * @ORM\Column(name="zipCode", type="string", length=255)
     */
    private $zipCode;



    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set address
     *
     * @param string $address
     * @return Business
     */
    public function setAddress($address)
    {
        $this->address = $address;
    
        return $this;
    }

    /**
     * Get address
     *
     * @return string 
     */
    public function getAddress()
    {
        return $this->address;
    }

    /**
     * Set businessAddress
     *
     * @param string $businessAddress
     * @return Business
     */
    public function setBusinessAddress($businessAddress)
    {
        $this->businessAddress = $businessAddress;
    
        return $this;
    }

    /**
     * Get businessAddress
     *
     * @return string 
     */
    public function getBusinessAddress()
    {
        return $this->businessAddress;
    }

    /**
     * Set businessDescription
     *
     * @param string $businessDescription
     * @return Business
     */
    public function setBusinessDescription($businessDescription)
    {
        $this->businessDescription = $businessDescription;
    
        return $this;
    }

    /**
     * Get businessDescription
     *
     * @return string 
     */
    public function getBusinessDescription()
    {
        return $this->businessDescription;
    }

    /**
     * Set businessSuiteApt
     *
     * @param string $businessSuiteApt
     * @return Business
     */
    public function setBusinessSuiteApt($businessSuiteApt)
    {
        $this->businessSuiteApt = $businessSuiteApt;
    
        return $this;
    }

    /**
     * Get businessSuiteApt
     *
     * @return string 
     */
    public function getBusinessSuiteApt()
    {
        return $this->businessSuiteApt;
    }

    /**
     * Set businessZipCode
     *
     * @param string $businessZipCode
     * @return Business
     */
    public function setBusinessZipCode($businessZipCode)
    {
        $this->businessZipCode = $businessZipCode;
    
        return $this;
    }

    /**
     * Get businessZipCode
     *
     * @return string 
     */
    public function getBusinessZipCode()
    {
        return $this->businessZipCode;
    }

    /**
     * Set ccSales
     *
     * @param string $ccSales
     * @return Business
     */
    public function setCcSales($ccSales)
    {
        $this->ccSales = $ccSales;
    
        return $this;
    }

    /**
     * Get ccSales
     *
     * @return string 
     */
    public function getCcSales()
    {
        return $this->ccSales;
    }

    /**
     * Set corporationName
     *
     * @param string $corporationName
     * @return Business
     */
    public function setCorporationName($corporationName)
    {
        $this->corporationName = $corporationName;
    
        return $this;
    }

    /**
     * Get corporationName
     *
     * @return string 
     */
    public function getCorporationName()
    {
        return $this->corporationName;
    }

    /**
     * Set dba
     *
     * @param string $dba
     * @return Business
     */
    public function setDba($dba)
    {
        $this->dba = $dba;
    
        return $this;
    }

    /**
     * Get dba
     *
     * @return string 
     */
    public function getDba()
    {
        return $this->dba;
    }

    /**
     * Set dob
     *
     * @param string $dob
     * @return Business
     */
    public function setDob($dob)
    {
        $this->dob = $dob;
    
        return $this;
    }

    /**
     * Get dob
     *
     * @return string 
     */
    public function getDob()
    {
        return $this->dob;
    }

    /**
     * Set email
     *
     * @param string $email
     * @return Business
     */
    public function setEmail($email)
    {
        $this->email = $email;
    
        return $this;
    }

    /**
     * Get email
     *
     * @return string 
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Set fedTaxId
     *
     * @param string $fedTaxId
     * @return Business
     */
    public function setFedTaxId($fedTaxId)
    {
        $this->fedTaxId = $fedTaxId;
    
        return $this;
    }

    /**
     * Get fedTaxId
     *
     * @return string 
     */
    public function getFedTaxId()
    {
        return $this->fedTaxId;
    }

    /**
     * Set firstName
     *
     * @param string $firstName
     * @return Business
     */
    public function setFirstName($firstName)
    {
        $this->firstName = $firstName;
    
        return $this;
    }

    /**
     * Get firstName
     *
     * @return string 
     */
    public function getFirstName()
    {
        return $this->firstName;
    }

    /**
     * Set highestSales
     *
     * @param string $highestSales
     * @return Business
     */
    public function setHighestSales($highestSales)
    {
        $this->highestSales = $highestSales;
    
        return $this;
    }

    /**
     * Get highestSales
     *
     * @return string 
     */
    public function getHighestSales()
    {
        return $this->highestSales;
    }

    /**
     * Set lastName
     *
     * @param string $lastName
     * @return Business
     */
    public function setLastName($lastName)
    {
        $this->lastName = $lastName;
    
        return $this;
    }

    /**
     * Get lastName
     *
     * @return string 
     */
    public function getLastName()
    {
        return $this->lastName;
    }

    /**
     * Set phoneNumber
     *
     * @param string $phoneNumber
     * @return Business
     */
    public function setPhoneNumber($phoneNumber)
    {
        $this->phoneNumber = $phoneNumber;
    
        return $this;
    }

    /**
     * Get phoneNumber
     *
     * @return string 
     */
    public function getPhoneNumber()
    {
        return $this->phoneNumber;
    }

    /**
     * Set ssn
     *
     * @param string $ssn
     * @return Business
     */
    public function setSsn($ssn)
    {
        $this->ssn = $ssn;
    
        return $this;
    }

    /**
     * Get ssn
     *
     * @return string 
     */
    public function getSsn()
    {
        return $this->ssn;
    }

    /**
     * Set suiteApt
     *
     * @param string $suiteApt
     * @return Business
     */
    public function setSuiteApt($suiteApt)
    {
        $this->suiteApt = $suiteApt;
    
        return $this;
    }

    /**
     * Get suiteApt
     *
     * @return string 
     */
    public function getSuiteApt()
    {
        return $this->suiteApt;
    }

    /**
     * Set type
     *
     * @param string $type
     * @return Business
     */
    public function setType($type)
    {
        $this->type = $type;
    
        return $this;
    }

    /**
     * Get type
     *
     * @return string 
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * Set yearInBusiness
     *
     * @param string $yearInBusiness
     * @return Business
     */
    public function setYearInBusiness($yearInBusiness)
    {
        $this->yearInBusiness = $yearInBusiness;
    
        return $this;
    }

    /**
     * Get yearInBusiness
     *
     * @return string 
     */
    public function getYearInBusiness()
    {
        return $this->yearInBusiness;
    }

    /**
     * Set zipCode
     *
     * @param string $zipCode
     * @return Business
     */
    public function setZipCode($zipCode)
    {
        $this->zipCode = $zipCode;
    
        return $this;
    }

    /**
     * Get zipCode
     *
     * @return string 
     */
    public function getZipCode()
    {
        return $this->zipCode;
    }
}