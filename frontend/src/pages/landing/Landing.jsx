import { Link } from 'react-router-dom'
import Navbar from '../../components/layout/Navbar'
import Footer from '../../components/layout/Footer'
import Button from '../../components/common/Button'
import SectionTitle from '../../components/common/SectionTitle'
import Card from '../../components/common/Card'
import dashboardPreview from '../../assets/dashboard-preview.svg'
import benefitAi from '../../assets/benefit-ai.svg'
import benefitReports from '../../assets/benefit-reports.svg'
import benefitCompliance from '../../assets/benefit-compliance.svg'
import './Landing.css'

const features = [
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
      </svg>
    ),
    iconStyle: { background: 'var(--color-accent-subtle)', color: 'var(--color-accent)' },
    title: 'Evaluaciones automatizadas',
    text: 'Realiza evaluaciones de cumplimiento de forma automática con cuestionarios inteligentes adaptados a tu sector.',
  },
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
      </svg>
    ),
    iconStyle: { background: '#ecfdf5', color: 'var(--color-success)' },
    title: 'Reportes inteligentes',
    text: 'Genera reportes detallados con análisis de brechas, niveles de cumplimiento y recomendaciones accionables.',
  },
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/>
      </svg>
    ),
    iconStyle: { background: '#fffbeb', color: 'var(--color-warning)' },
    title: 'Monitoreo en tiempo real',
    text: 'Visualiza el estado de cumplimiento de tu organización con dashboards interactivos y actualizados en tiempo real.',
  },
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
      </svg>
    ),
    iconStyle: { background: 'var(--color-accent-subtle)', color: 'var(--color-accent)' },
    title: 'Seguridad de datos',
    text: 'Protege la información sensible con cifrado de extremo a extremo y controles de acceso basados en roles.',
  },
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
      </svg>
    ),
    iconStyle: { background: '#ecfdf5', color: 'var(--color-success)' },
    title: 'Gestión multiusuario',
    text: 'Invita a tu equipo, asigna roles y colabora en tiempo real en las evaluaciones de cumplimiento.',
  },
  {
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
      </svg>
    ),
    iconStyle: { background: '#fffbeb', color: 'var(--color-warning)' },
    title: 'IA Generativa',
    text: 'Asistente inteligente que te ayuda a interpretar resultados y generar recomendaciones personalizadas.',
  },
]

const steps = [
  { number: 1, title: 'Crea tu cuenta', text: 'Regístrate con tu correo corporativo y configura el perfil de tu empresa en menos de 2 minutos.' },
  { number: 2, title: 'Realiza evaluaciones', text: 'Completa los cuestionarios inteligentes diseñados por expertos en privacidad y cumplimiento normativo.' },
  { number: 3, title: 'Obtén resultados', text: 'Recibe reportes detallados con análisis, recomendaciones y un plan de acción para mejorar tu cumplimiento.' },
]

function Landing() {
  return (
    <>
      <Navbar />
      <main>
        <section className="hero">
          <div className="hero-bg">
            <div className="hero-bg-glow" />
          </div>
          <div className="container">
            <div className="hero-badge">
              <span>Nueva versión disponible</span>
            </div>
            <h1 className="hero-title">
              Cumplimiento normativo<br />
              <span className="hero-title-accent">impulsado por IA</span>
            </h1>
            <p className="hero-subtitle">
              Automatiza, monitorea y gestiona el cumplimiento de privacidad de tu empresa
              con nuestra plataforma inteligente. Reduce riesgos y ahorra tiempo.
            </p>
            <div className="hero-actions">
              <Link to="/register" className="btn btn-primary btn-lg">Comenzar gratis</Link>
              <a href="#features" className="btn btn-secondary btn-lg">Ver demo</a>
            </div>
            <div className="hero-preview">
              <img src={dashboardPreview} alt="Vista previa del dashboard" />
            </div>
          </div>
        </section>

        <section id="features" className="section">
          <div className="container">
            <SectionTitle
              badge="Características"
              title="Todo lo que necesitas para cumplir"
              subtitle="Una plataforma completa que simplifica la gestión de privacidad y cumplimiento normativo."
            />
            <div className="features-grid">
              {features.map((f, i) => (
                <Card key={i} padding="sm">
                  <div className="card-icon" style={f.iconStyle}>{f.icon}</div>
                  <h3 className="card-title">{f.title}</h3>
                  <p className="card-text">{f.text}</p>
                </Card>
              ))}
            </div>
          </div>
        </section>

        <section id="how-it-works" className="section steps">
          <div className="container">
            <SectionTitle
              badge="Cómo funciona"
              title="Comienza en minutos"
              subtitle="Tres pasos simples para transformar la gestión de cumplimiento de tu empresa."
            />
            <div className="steps-grid">
              {steps.map((s) => (
                <div className="step-card" key={s.number}>
                  <div className="step-number">{s.number}</div>
                  <h3 className="step-title">{s.title}</h3>
                  <p className="step-text">{s.text}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section id="benefits" className="section">
          <div className="container">
            <SectionTitle
              badge="Beneficios"
              title="Por qué elegir CAVALTEC"
              subtitle="La plataforma que están utilizando empresas líderes para gestionar su cumplimiento normativo."
            />
            <div className="benefits-list">
              <div className="benefit-item">
                <div>
                  <div className="benefit-label">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="10"/></svg>
                    Inteligencia Artificial
                  </div>
                  <h3 className="benefit-title">Análisis impulsado por IA</h3>
                  <p className="benefit-text">
                    Nuestro motor de IA analiza tus respuestas y genera recomendaciones personalizadas basadas en las mejores prácticas del sector y regulaciones vigentes.
                  </p>
                </div>
                <img src={benefitAi} alt="Análisis con IA" className="benefit-image" />
              </div>
              <div className="benefit-item reverse">
                <div>
                  <div className="benefit-label">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="10"/></svg>
                    Reportes
                  </div>
                  <h3 className="benefit-title">Reportes profesionales</h3>
                  <p className="benefit-text">
                    Genera reportes ejecutivos en PDF con análisis detallados, gráficos interactivos y recomendaciones accionables para la toma de decisiones.
                  </p>
                </div>
                <img src={benefitReports} alt="Reportes profesionales" className="benefit-image" />
              </div>
              <div className="benefit-item">
                <div>
                  <div className="benefit-label">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="10"/></svg>
                    Cumplimiento
                  </div>
                  <h3 className="benefit-title">Actualización normativa</h3>
                  <p className="benefit-text">
                    Mantente al día con los cambios regulatorios. Nuestra plataforma se actualiza automáticamente para reflejar las últimas normativas de privacidad.
                  </p>
                </div>
                <img src={benefitCompliance} alt="Actualización normativa" className="benefit-image" />
              </div>
            </div>
          </div>
        </section>

        <section className="section dashboard-preview">
          <div className="container">
            <SectionTitle
              title="Dashboard en tiempo real"
              subtitle="Visualiza el estado de cumplimiento de tu organización de un vistazo."
            />
            <img src={dashboardPreview} alt="Dashboard en tiempo real" />
          </div>
        </section>

        <section className="cta">
          <div className="container">
            <h2 className="cta-title">¿Listo para comenzar?</h2>
            <p className="cta-text">
              Únete a las empresas que ya confían en CAVALTEC para gestionar su cumplimiento normativo. Comienza hoy sin compromiso.
            </p>
            <div className="hero-actions">
              <Link to="/register" className="btn btn-primary btn-lg cta-btn">Comenzar gratis</Link>
              <Link to="/login" className="btn btn-lg btn-outline cta-btn-outline">Iniciar sesión</Link>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </>
  )
}

export default Landing
