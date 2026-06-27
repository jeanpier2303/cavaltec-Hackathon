import { Link } from 'react-router-dom'
import './Logo.css'

function Logo({ showText = true, size = 'md' }) {
  const iconSize = size === 'lg' ? 36 : 32
  const fontSize = size === 'lg' ? 22 : 20

  return (
    <Link to="/" className="logo">
      <span
        className="logo-icon"
        style={{ width: iconSize, height: iconSize, fontSize: iconSize * 0.5 }}
      >
        C
      </span>
      {showText && (
        <span className="logo-text" style={{ fontSize }}>
          CAVALTEC
        </span>
      )}
    </Link>
  )
}

export default Logo
