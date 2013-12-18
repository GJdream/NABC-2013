<?php

namespace NABC\AdminBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Admin
 *
 * @ORM\Table(name="admin")
 * @ORM\Entity
 */
class Admin
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
     * @ORM\Column(name="adminid", type="string", length=255)
     */
    private $adminid;

    /**
     * @var string
     *
     * @ORM\Column(name="adminpwd", type="string", length=255)
     */
    private $adminpwd;


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
     * Set adminid
     *
     * @param string $adminid
     * @return Admin
     */
    public function setAdminid($adminid)
    {
        $this->adminid = $adminid;
    
        return $this;
    }

    /**
     * Get adminid
     *
     * @return string 
     */
    public function getAdminid()
    {
        return $this->adminid;
    }

    /**
     * Set adminpwd
     *
     * @param string $adminpwd
     * @return Admin
     */
    public function setAdminpwd($adminpwd)
    {
        $this->adminpwd = $adminpwd;
    
        return $this;
    }

    /**
     * Get adminpwd
     *
     * @return string 
     */
    public function getAdminpwd()
    {
        return $this->adminpwd;
    }
}