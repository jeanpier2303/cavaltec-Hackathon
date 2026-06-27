import { Link } from 'react-router-dom'
import Logo from '../common/Logo'
import Button from '../common/Button'
import './Navbar.css'

function Navbar() {
  return (
    <nav className="navbar">
      <div className="container">
        <Logo />
        <div className="navbar-links">
          <a href="#features" className="navbar-link">Características</a>
          <a href="#how-it-works" className="navbar-link">Cómo funciona</a>
          <a href="#benefits" className="navbar-link">Beneficios</a>
        </div>
        <div className="navbar-actions">
          <Link to="/login" className="btn btn-ghost">Iniciar sesión</Link>
          <Link to="/register" className="btn btn-primary">Comenzar gratis</Link>
          <button className="navbar-toggle" aria-label="Menú">
            <svg className="navbar-toggle-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
              <line x1="4" y1="6" x2="20" y2="6"/>
              <line x1="4" y1="12" x2="20" y2="12"/>
              <line x1="4" y1="18" x2="20" y2="18"/>
            </svg>
          </button>
        </div>
      </div>
    </nav>
  )
}

export default Navbar
