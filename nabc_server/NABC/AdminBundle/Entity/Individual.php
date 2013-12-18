<?php

namespace NABC\AdminBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Individual
 *
 * @ORM\Table(name="individual")
 * @ORM\Entity
 */
class Individual
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
     * @ORM\Column(name="firstName", type="string", length=255)
     */
    private $firstName;

    /**
     * @var string
     *
     * @ORM\Column(name="lastName", type="string", length=255)
     */
    private $lastName;

    /**
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=255)
     */
    private $email;

    /**
     * @var string
     *
     * @ORM\Column(name="phoneNumber", type="string", length=255)
     */
    private $phoneNumber;

    /**
     * @var string
     *
     * @ORM\Column(name="address", type="string", length=255)
     */
    private $address;

    /**
     * @var string
     *
     * @ORM\Column(name="suiteApt", type="string", length=255, nullable=true)
     */
    private $suiteApt;

    /**
     * @var string
     *
     * @ORM\Column(name="zipCode", type="string", length=255)
     */
    private $zipCode;

    /**
     * @var string
     *
     * @ORM\Column(name="SSN", type="string", length=255)
     */
    private $sSN;

    /**
     * @var string
     *
     * @ORM\Column(name="DOB", type="string", length=255)
     */
    private $dOB;

    /**
     * @var string
     *
     * @ORM\Column(name="DBA", type="string", length=255, nullable=true)
     */
    private $dBA;


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
     * Set firstName
     *
     * @param string $firstName
     * @return Individual
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
     * Set lastName
     *
     * @param string $lastName
     * @return Individual
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
     * Set email
     *
     * @param string $email
     * @return Individual
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
     * Set phoneNumber
     *
     * @param string $phoneNumber
     * @return Individual
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
     * Set address
     *
     * @param string $address
     * @return Individual
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
     * Set suiteApt
     *
     * @param string $suiteApt
     * @return Individual
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
     * Set zipCode
     *
     * @param string $zipCode
     * @return Individual
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

    /**
     * Set sSN
     *
     * @param string $sSN
     * @return Individual
     */
    public function setSSN($sSN)
    {
        $this->sSN = $sSN;
    
        return $this;
    }

    /**
     * Get sSN
     *
     * @return string 
     */
    public function getSSN()
    {
        return $this->sSN;
    }

    /**
     * Set dOB
     *
     * @param string $dOB
     * @return Individual
     */
    public function setDOB($dOB)
    {
        $this->dOB = $dOB;
    
        return $this;
    }

    /**
     * Get dOB
     *
     * @return string 
     */
    public function getDOB()
    {
        return $this->dOB;
    }

    /**
     * Set dBA
     *
     * @param string $dBA
     * @return Individual
     */
    public function setDBA($dBA)
    {
        $this->dBA = $dBA;
    
        return $this;
    }

    /**
     * Get dBA
     *
     * @return string 
     */
    public function getDBA()
    {
        return $this->dBA;
    }
}